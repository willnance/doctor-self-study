class Question < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments
  
  attr_accessible :subject, :question, :position, :answerA, :answerB, :answerC, :answerD, :solution, :visible, :year , :rotation
  after_save :create_assignments
  
  def create_assignments
    assigned_users = User.order("year ASC")
    unless year == nil
      assigned_users.where(:year => self.year)
    end
    unless rotation == nil
      assigned_users.where(:rotation => self.rotation)
    end
    assigned_users.each do |user|
      existing_assignment = Assignment.find_by_user_id_and_question_id(user.id,self.id)
      if existing_assignment == nil
        Assignment.create(:user_id => user.id , :question_id => self.id)
      end
    end     
  end

end
