class Attachment < ActiveRecord::Base
  attr_accessible :description, :file
  belongs_to :attachable, :polymorphic => true
  mount_uploader :file, FileUploader
end
# == Schema Information
#
# Table name: attachments
#
#  id              :integer         not null, primary key
#  description     :text
#  file            :string(255)
#  attachable_id   :integer
#  attachable_type :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

