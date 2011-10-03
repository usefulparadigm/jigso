require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: entries
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  body_html  :text
#  item_id    :integer
#  user_id    :integer
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  up_votes   :integer         default(0), not null
#  down_votes :integer         default(0), not null
#

