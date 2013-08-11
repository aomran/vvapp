class Image < ActiveRecord::Base
  belongs_to :submission

  mount_uploader :image_file, ImageUploader
end
