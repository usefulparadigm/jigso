class Item < ActiveRecord::Base
  has_many :user_items
  has_many :users, :through => :user_items, :uniq => true
  validates_presence_of :key, :title
  validates_uniqueness_of :key
  default_scope order('created_at DESC')

  make_voteable

  def url; self.key end
  def url=(url); self.key = url end
  # def to_s; url end

  def related_entries
    Entry.where(:item_id => self.key)
  end
  
  def image
    image_url || Settings.item.default_image
  end

end

# == Schema Information
#
# Table name: items
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  image       :string(255)
#  key         :string(20)
#  created_at  :datetime
#  updated_at  :datetime
#

