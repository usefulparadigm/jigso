class Entry < ActiveRecord::Base
  attr_accessible :title, :body, :attachments_attributes
  has_many   :attachments, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true

  include ActiveRecord::Transitions

  state_machine do 
    state :draft
    state :published
    event :publish do
      transitions :to => :published, :from => :draft #, :on_transition => :do_publish
    end
  end
    
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

