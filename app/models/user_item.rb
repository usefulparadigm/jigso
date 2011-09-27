class UserItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  # activity streams  
  fires :new_item, :on => :create, :actor => :user, :secondary_subject => :item

end
