class Image < ActiveRecord::Base
  belongs_to :submission

  mount_uploader :image_file, ImageUploader

  def filename
    File.basename(image_file.url, '.*').titleize
  end
end
