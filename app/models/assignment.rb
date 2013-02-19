class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  
  # attr_accessible :title, :body
end
