class User < ActiveRecord::Base
  has_many :albums
  attr_accessible :name, :email, :password, :password_confirmation
  acts_as_authentic do |c| 
  	c.login_field = :email
  end
end
