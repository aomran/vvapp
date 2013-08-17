require 'test_helper'

class ImageUploaderTest < ActiveSupport::TestCase
  test "non jpeg/jpg images are not stored" do
    image = Image.new
    uploader = ImageUploader.new(image, :image_file)

    assert_raises CarrierWave::IntegrityError do
      uploader.store!(File.open("#{Rails.root}/test/fixtures/images/perfect_size.png"))
    end

    assert_nothing_raised CarrierWave::IntegrityError do
      uploader.store!(File.open("#{Rails.root}/test/fixtures/images/perfect_size.jpg"))
    end
  end

  test "gets image dimensions" do
    image = Image.new
    uploader = ImageUploader.new(image, :image_file)
    uploader.store!(File.open("#{Rails.root}/test/fixtures/images/perfect_size.jpg"))

    assert_equal 1024, image.width
    assert_equal 768, image.height
  end

  test "gets image file name" do
    image = Image.new
    uploader = ImageUploader.new(image, :image_file)
    uploader.store!(File.open("#{Rails.root}/test/fixtures/images/perfect_size.jpg"))

    assert_equal "perfect_size.jpg", image.file_name
  end
end
