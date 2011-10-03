require 'test_helper'

class UserItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

