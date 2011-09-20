class Entry < ActiveRecord::Base
  attr_accessible :title, :body, :attachments_attributes, :tag_list
  has_many   :attachments, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true

  belongs_to :user

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

  def related_entries; find_related_tags end
      
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
#

