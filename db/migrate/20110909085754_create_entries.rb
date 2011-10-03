class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :title
      t.text :body
      t.text :body_html
      t.integer :item_id
      t.integer :user_id
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
