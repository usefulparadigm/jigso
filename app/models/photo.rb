class Photo < Attachment
  mount_uploader :image, PhotoUploader
end
