class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
