class Question < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments
  
   attr_accessible :subject, :question, :answerA, :answerB, :answerC, :answerD, :solution, :visible
end
