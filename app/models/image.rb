class Image < ActiveRecord::Base
  belongs_to :submission

  mount_uploader :image_file, ImageUploader

  validate :image_dimensions

  def filename
    File.basename(image_file.url, '.*').titleize
  end

  def image_dimensions
    if width > 1024
      errors.add(:width, "You cannot upload a file whose width is greater than 1024")
    end
    if height > 768
      errors.add(:height, "You cannot upload a file whose height is greater than 768")
    end
    if width < 750 && height < 750
      errors.add(:width, "You cannot upload a file with both width and height less than 750")
    end

  end

end
