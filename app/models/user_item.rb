class UserItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  # activity streams  
  fires :new_item, :on => :create, :actor => :user, :secondary_subject => :item

end

# == Schema Information
#
# Table name: user_items
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  item_id    :integer
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

