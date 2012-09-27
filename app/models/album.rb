class Album < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :name, :pictures_attributes
  validates :name, :uniqueness => {:scope => :user_id}, :presence => true
  has_many :pictures, :dependent => :destroy
  accepts_nested_attributes_for :pictures
end
