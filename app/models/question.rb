#authors Will Nance and Sanket Prabhu
#ALL jobs and models must extend the Autoscaling module for cheap Heroku deployment
require 'heroku_resque_auto_scale'

class Question < ActiveRecord::Base 
  extend HerokuAutoScaler::AutoScaling
  has_many :assignments
  has_many :users, :through => :assignments
  attr_accessible :subject, :question, :position, :answerA, :answerB, :answerC, :answerD, :solution, :visible, :year , :rotation, :schedule
  after_save :create_assignments
  after_create :create_assignments
  before_destroy :clear_assignments
  
  
  # breaks the link between the users and this question and then destroys the assignment
  # presumably if you delete a question then you dont care about any of the users' responses to it.
  def clear_assignments
    assignments = self.assignments
    assignments.each do |a|
      a.user.assignments.delete(a)
      a.destroy
    end
  end
  
  
  #use the rotation and year of the resident and questions to make the assignments
  #while preserving the assignments that were previously answered in past rotations.
  def create_assignments
    self.assignments.each do |a|
      #want to keep the history of responses even if the question no longer applies.
      #it could be that the question was answered in a prior rotation.
      a.destroy unless a.responded
    end
    assigned_users = User.scoped
    assigned_users =assigned_users.where(:rotation => self.rotation)unless rotation == nil
    assigned_users =assigned_users.where(:year => self.year) unless year == nil
    make_assignments(assigned_users)
    clear_old_assignments
  end
  
  
  #this just makes sure that there arent any assignments with a nil userr or question.
  #this can happen if a user or question breaks its link with an assignment.
  def clear_old_assignments
    nil_user = Assignment.where(:user_id => nil)
    nil_question =Assignment.where(:question_id => nil)
    nil_user.each do |a|
      nil_question << a
    end
    nil_question.each do |a| a.destroy end
  end
  
  
  #take a list of users and create a assignment link between self (the question) and each user 
  def make_assignments(assigned_users)
    assigned_users.each do |user|
      existing_assignment = Assignment.find_by_user_id_and_question_id(user.id,self.id)
      Assignment.create(:user_id => user.id , :question_id => self.id)if existing_assignment == nil
    end  
  end
  

end
