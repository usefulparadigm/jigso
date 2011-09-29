class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.string :key

      t.timestamps
    end
    add_index :items, :key
  end

  def self.down
    remove_index :items, :key
    drop_table :items
  end
end
