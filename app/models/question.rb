#ALL jobs and models must extend the Autoscaling module for cheap Heroku deployment
require 'heroku_resque_auto_scale'
class Question < ActiveRecord::Base 
  extend HerokuAutoScaler::AutoScaling
  has_many :assignments
  has_many :users, :through => :assignments
  
  attr_accessible :subject, :question, :position, :answerA, :answerB, :answerC, :answerD, :solution, :visible, :year , :rotation, :schedule
  after_save :create_assignments
  after_create :create_assignments
  
  def create_assignments
    self.assignments = self.assignments.destroy
    assigned_users = User.scoped
    assigned_users =assigned_users.where(:rotation => self.rotation)unless rotation == nil
    assigned_users =assigned_users.where(:year => self.year) unless year == nil
    make_assignments(assigned_users)
    clear_old_assignments
  end
  def clear_old_assignments
    nil_user = Assignment.where(:user_id => nil)
    nil_question =Assignment.where(:question_id => nil)
    nil_user.each do |a|
      nil_question << a
    end
    nil_question.each do |a| a.destroy end
  end
  def make_assignments(assigned_users)
    assigned_users.each do |user|
      existing_assignment = Assignment.find_by_user_id_and_question_id(user.id,self.id)
      if existing_assignment == nil
        Assignment.create(:user_id => user.id , :question_id => self.id)
      end
    end  
  end
  

end
