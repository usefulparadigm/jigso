class Item < ActiveRecord::Base
  has_many :user_items
  has_many :users, :through => :user_items, :uniq => true
  has_many :entries #, :primary_key => :url
  validates_presence_of :title, :url
  validates_uniqueness_of :url
  default_scope order('created_at DESC')

  make_voteable

  # def related_entries
  #   Entry.where(:item_id => self.key)
  # end
  
  def image
    image_url.blank? ? Settings.item.default_image : image_url
  end

end


# == Schema Information
#
# Table name: items
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  url         :string(255)
#  image_url   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

