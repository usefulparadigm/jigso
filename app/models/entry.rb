class Entry < ActiveRecord::Base
  attr_accessible :title, :body, :attachments_attributes, :tag_list, :item_id
  attr_accessor :keep_the_item
  has_many   :attachments, :as => :attachable, :dependent => :destroy
  belongs_to :user
  # belongs_to :item

  accepts_nested_attributes_for :attachments, :allow_destroy => true
  default_scope order('created_at DESC')

  make_voteable
  acts_as_taggable
  acts_as_followable

  self.per_page = 10

  include ActiveRecord::Transitions

  state_machine do 
    state :draft
    state :published
    event :publish do
      transitions :to => :published, :from => :draft #, :on_transition => :do_publish
    end
  end
  
  auto_html_for :body do
    html_escape
    image
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  # callbacks
  before_save do |entry|
    if entry.item_id
      item = Item.find_or_create_by_key(entry.item_id)
      item.users << entry.user if entry.keep_the_item
    end  
  end

  # activity streams  
  fires :new_entry, :on => :create, :actor => :user, :secondary_subject => :item

  # scopes & utility methods
  def related_entries; find_related_tags end

  # items
  def item; Item.find_by_key(self.item_id) end
  def item=(item); self.item_id = item.key end

end

# == Schema Information
#
# Table name: entries
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#  state      :string(255)
#  up_votes   :integer         default(0), not null
#  down_votes :integer         default(0), not null
#  body_html  :string(255)
#  user_id    :integer
#

