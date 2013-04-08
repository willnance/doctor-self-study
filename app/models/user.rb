require 'digest/sha2'
require "QuestionMailer"
#ALL jobs and models must extend the Autoscaling module for cheap Heroku deployment
require 'heroku_resque_auto_scale'
class User < ActiveRecord::Base 
  extend HerokuAutoScaler::AutoScaling
  has_many :assignments
  has_many :questions , :through => :assignments
  before_save :create_hashed_password
  after_save :clear_password
  after_save :assign_questions
  after_create :assign_questions
  after_create :deliverWelcome
  attr_accessor :password
  attr_accessible :title, :body, :firstName, :lastName, :username ,:hashedPassword,:year, :rotation,  :password , :email
  
  def deliverWelcome
   QuestionMailer.deliver_welcome(self)
  end
  
  def assign_questions
    self.assignments = self.assignments.destroy
    make_assignments(filtered_questions())
    make_assignments(universal_questions())
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
  def filtered_questions
    assigned_questions = Question.scoped
    # puts "all questions #{assigned_questions.size}"
    assigned_questions = assigned_questions.where(:rotation => rotation) unless rotation == nil
    # puts "filtered on rotation #{assigned_questions.size}"
    assigned_questions = assigned_questions.where(:year => year)         unless year == nil
    # puts "filtered on year #{assigned_questions.size}"
    return assigned_questions
  end
  def universal_questions()
    assigned_questions = Question.scoped
    assigned_questions =assigned_questions.where(:rotation => nil) unless rotation == nil
    #puts "universal rotation #{assigned_questions.size}"
    assigned_questions =assigned_questions.where(:year => nil) unless year == nil
    #puts "universal year #{assigned_questions.size}"
    return assigned_questions
  end
  def make_assignments(assigned_questions)
    assigned_questions.each do |question|
      existing_assignment = Assignment.find_by_user_id_and_question_id(self.id,question.id)
      if existing_assignment == nil
        Assignment.create(:question_id => question.id , :user_id => self.id)
      end
    end
  end
  
  
  def self.authenticate(username="",  password="")
    user = User.find_by_username(username)
    if user  && user.password_match?(password)
      return user 
    else 
      return false
    end
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
  
  def as_json(options={})
    
    {
      :created_at =>created_at,
      :firstName =>  firstName,
      :hashedPassword =>hashedPassword,
      :id => id ,
      :lastName =>lastName,
      :rotation => rotation ,
      :updated_at =>updated_at ,
      :username =>username,
      :year =>year,
      :assignments => self.assignments,
    }
    
  end
  
  
end
