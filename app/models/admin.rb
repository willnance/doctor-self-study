#authors Will Nance and Sanket Prabhu
require 'digest/sha2'
#ALL jobs and models must extend the Autoscaling module for cheap Heroku deployment
require 'heroku_resque_auto_scale'
require "question_mailer"

 # This represents an administrator account for the website. This person 
 # has the ability to make new questions,enroll new users and edit
 # users responses to questions.  
class Admin < ActiveRecord::Base
  extend HerokuAutoScaler::AutoScaling

  scope :sorted ,  order("Admin.firstName ASC , Admin.lastName ACS")
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  before_save :create_hashed_password
  after_save :clear_password
  attr_accessible :title, :body, :firstName, :lastName, :username, :hashedPassword , :email , :salt , :password
  validates :firstName , :presence => true, :length => {:maximum=> 25}
  validates :lastName , :presence => true, :length => {:maximum=> 50}
  validates :username , :presence => true, :length => {:within=> 8..25}, :uniqueness => true
  validates :email , :presence => true, :length => {:maximum => 100} , :format => {:with => EMAIL_REGEX} , :confirmation => true
  attr_accessor :password
  validates_length_of :password, :within => 8..25, :on => :create
  
  
  
  def send_password_change_instructions 
    QuestionMailer.send_password_reset_instructions(self).deliver
  end
  
  
  # utility method
  def name
    "#{firstName} #{lastName}"
  end
  
  
  # single method for authentication. The encryption and salting
  # is hidden in the helper methods.
  def self.authenticate(username="",  password="")
    user = Admin.find_by_username(username)
    if user  && user.password_match?(password)
      return user 
    else 
      return false
    end
  end
  
  
  # encryption method
  def self.hash_with_salt(password="", salt = "")
    Digest::SHA2.hexdigest("put #{salt} on the #{password}")
  end
  
  
  # password salt generator
  def self.make_salt(username="")
    Digest::SHA2.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
 
  
  # utility method for hiding away the test for password match
  def password_match?( password="")
    hashedPassword == Admin.hash_with_salt(password, salt)
  end
  
  
  private
  
  
  # method for taking the password entered from a form or command line and 
  #writing that password to the database. 
  def create_hashed_password
    #only hash passwords if the password variable has been set
    unless password.blank?
      self.salt = Admin.make_salt(username) if salt.blank?
      self.hashedPassword = Admin.hash_with_salt(password , salt)
    end
  end
  
  
  # clears the password from the class so that no one can hack the plain text password.
  # I'm not 100% sure this makes it secure, but it makes it more secure than otherwise . . .
  def clear_password
    self.password=nil
  end
  
  
end
