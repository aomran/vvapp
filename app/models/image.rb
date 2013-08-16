class Image < ActiveRecord::Base
  belongs_to :submission

  mount_uploader :image_file, ImageUploader
 # validate :unique_image_filename
  validate :image_dimensions
  validates :file_name, uniqueness: true

  def filename
    File.basename(image_file.url, '.*').titleize
  end

  def image_dimensions
    if width > 1024
      errors.add(:width, "Vous ne pouvez pas attacher une image avec une largeur plus grande que 1024px")
    end
    if height > 768
      errors.add(:height, "Vous ne pouvez pas attacher une image avec une hauteur plus grande que 768px")
    end
    if width < 750 && height < 750
      errors.add(:width, "Vous ne pouvez pas attacher une image qui n'a pas au moins une dimension (largeur ou hauteur) plus grande que 750px")
    end

  end

end
