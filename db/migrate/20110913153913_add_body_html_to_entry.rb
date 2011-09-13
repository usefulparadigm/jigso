class AddBodyHtmlToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :body_html, :string
  end

  def self.down
    remove_column :entries, :body_html
  end
end
