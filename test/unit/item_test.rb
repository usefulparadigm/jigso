require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

