class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  
  attr_accessible :title, :body, :user_id, :question_id
  
  
  
  def as_json(options={})
    
    {
      :correct => correct,
      :created_at =>  created_at,
      :id => id, 
      :question_id => question_id,
      :response => response ,
      :updated_at => updated_at,
      :user_id => user_id,
      :question => self.question
    }
  end
end
