class Picture < ActiveRecord::Base
  attr_accessible :album_id, :avatar, :tag_attributes
  belongs_to :album
  has_attached_file :avatar, :styles => { :medium => "300x300>" },
                             :storage => :dropbox,
                             :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
                             :dropbox_options => {
                               :path => proc { |style| "photos/#{style}/#{id}_#{avatar.original_filename}"}
                              }
  has_one :tag, :dependent => :destroy
  accepts_nested_attributes_for :tag
end
