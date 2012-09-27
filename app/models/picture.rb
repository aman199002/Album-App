class Picture < ActiveRecord::Base
  attr_accessible :album_id, :avatar, :tag_attributes
  belongs_to :album
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :large => "500x500>" }
  has_one :tag, :dependent => :destroy
  accepts_nested_attributes_for :tag
end
