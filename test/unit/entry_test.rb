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
#  created_at :datetime
#  updated_at :datetime
#  state      :string(255)
#  up_votes   :integer         default(0), not null
#  down_votes :integer         default(0), not null
#  body_html  :string(255)
#  user_id    :integer
#

