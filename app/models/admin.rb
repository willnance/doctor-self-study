require 'digest/sha2'
class Admin < ActiveRecord::Base
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
  
  def name
    "#{firstName} #{lastName}"
  end
  def self.authenticate(username="",  password="")
    user = Admin.find_by_username(username)
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
    Digest::SHA2.hexdigest("Use #{username} with #{Time.now} to make salt")
  end
 
  def password_match?( password="")
    hashedPassword == Admin.hash_with_salt(password, salt)
  end
  private
  def create_hashed_password
    #only hash passwords if the password variable has been set
    unless password.blank?
      self.salt = Admin.make_salt(username) if salt.blank?
      self.hashedPassword = Admin.hash_with_salt(password , salt)
    end
  end
  def clear_password
    self.password=nil
  end
end
