require 'Digest/SHA2'
class User < ActiveRecord::Base
  has_many :assignments
  has_many :questions , :through => :assignments
  after_save :assign_questions
  attr_accessor :password
   
  def assign_questions
    assigned_questions = Question.order("year ASC")
    unless year == nil
      assigned_questions.where(:year => self.year)
    end
    unless rotation == nil
      assigned_questions.where(:rotation => self.rotation)
    end
    assigned_questions.each do |question|
      existing_assignment = Assignment.find_by_user_id_and_question_id(self.id,question.id)
      
      if existing_assignment == nil
        Assignment.create(:question_id => question.id , :user_id => self.id)
      end
    end
  end
  def self.authenticate(username="",  passwordHash="")
    
  end
  def self.hash_with_salt(password="", salt = "")
    Digest::SHA2.hexdigest("put #{salt} on the #{password}")
  end
  def self.make_salt(username="")
    Digest::SHA2.hexdigest("Username#{salt}")
  end
  def password_match?( password="")
    hashedPassword == User.hash_with_salt(password, salt)
  end
  def create_hashed_password
    unless password.blank?
      self.salt = Admin.make_salt(username) if salt.blank?
      self.hashedPassword= User.hash_with_salt(password , salt)
    end
  end
  def clear_password
    self.password=nil
  end
  
  attr_accessible :title, :body, :firstName, :lastName, :username ,:hashedPassword,:year, :rotation
end
