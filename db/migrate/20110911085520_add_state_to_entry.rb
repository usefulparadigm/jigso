class AddStateToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :state, :string
    add_index :entries, :state
  end

  def self.down
    remove_index :entries, :state
    remove_column :entries, :state
  end
end
