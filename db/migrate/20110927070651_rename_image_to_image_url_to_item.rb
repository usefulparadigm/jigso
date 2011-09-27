class RenameImageToImageUrlToItem < ActiveRecord::Migration
  def self.up
    rename_column :items, :image, :image_url
  end

  def self.down
    rename_column :items, :image_url, :image
  end
end
