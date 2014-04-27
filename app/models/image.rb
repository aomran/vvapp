class Image < ActiveRecord::Base
  belongs_to :submission

  mount_uploader :image_file, ImageUploader
 # validate :unique_image_filename
  validate :image_dimensions
  validates :file_name, uniqueness: true

  def image_dimensions
    if width < 1500 || height < 1500
      errors.add(:width, "Vous ne pouvez pas attacher une image qui a une dimension (largeur ou hauteur) plus petit que 1500px")
    end
    if width < 2100 && height < 2100
      errors.add(:width, "Vous ne pouvez pas attacher une image qui n'a pas au moins une dimension (largeur ou hauteur) 2100px ou plus grande")
    end
    if width > 3300 || height > 3300
      errors.add(:width, "Vous ne pouvez pas attacher une image qui a une dimension (largeur ou hauteur) plus grand que 3300px")
    end
    if width > 2550 && height > 2550
      errors.add(:width, "Vous ne pouvez pas attacher une image qui n'a pas au moins une dimension (largeur ou hauteur) 2550px ou plus petit")
    end
  end

end
