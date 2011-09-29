class CreateAuthentications < ActiveRecord::Migration
  def self.up
    create_table :authentications do |t|
      t.column :user_id, :integer
      t.column :provider, :string
      t.column :uid, :string

      t.timestamps
    end
  end

  def self.down
    drop_table :authentications
  end
end
