class AddVoteFieldsToEntry < ActiveRecord::Migration
  def self.up
    add_column :users, :up_votes, :integer, :null => false, :default => 0
    add_column :users, :down_votes, :integer, :null => false, :default => 0
    add_column :entries, :up_votes, :integer, :null => false, :default => 0
    add_column :entries, :down_votes, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :users, :down_votes
    remove_column :users, :up_votes
    remove_column :entries, :down_votes
    remove_column :entries, :up_votes
  end
end
