require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "wide images are invalid" do
    image = Image.new
    uploader = ImageUploader.new(image, :image_file)

    uploader.store!(File.open("#{Rails.root}/test/fixtures/images/too_wide_image.jpg"))

    image.valid?
    assert image.errors[:width].any?, 'Wide image should be invalid'
  end

  test "tall images are invalid" do
    image = Image.new
    uploader = ImageUploader.new(image, :image_file)

    uploader.store!(File.open("#{Rails.root}/test/fixtures/images/too_tall_image.jpg"))

    image.valid?
    assert image.errors[:height].any?, 'Tall image should be invalid'
  end
end
