class User < ActiveRecord::Base
  has_many :assignments
  has_many :questions , :through => :assignments
  
 attr_accessible :title, :body, :firstName, :lastName, :username ,:hashedPassword,:year
end
