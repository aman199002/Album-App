class Tag < ActiveRecord::Base
  belongs_to :picture
  attr_accessible :name, :picture_id
end
