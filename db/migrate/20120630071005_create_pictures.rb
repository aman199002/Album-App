class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :album_id
      t.has_attached_file :avatar
      t.timestamps
    end
  end
end
