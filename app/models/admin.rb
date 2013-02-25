class Admin < ActiveRecord::Base
  attr_accessible :title, :body, :firstName, :lastName, :username, :hashedPassword
end
