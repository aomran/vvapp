require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "wide images are invalid" do
    image = Image.new
    image.image_file = File.open("#{Rails.root}/test/fixtures/images/too_wide_image.jpg")
    image.valid?
    assert image.errors[:width].any?, 'Wide image should be invalid'
  end

  test "tall images are invalid" do
    image = Image.new
    image.image_file = File.open("#{Rails.root}/test/fixtures/images/too_tall_image.jpg")

    image.valid?
    assert image.errors[:height].any?, 'Tall image should be invalid'
  end

  test "small images are invalid" do
    image = Image.new
    image.image_file = File.open("#{Rails.root}/test/fixtures/images/too_small_image.jpg")

    image.valid?
    assert image.errors[:width].any?, 'Small image should be invalid'
  end
  test "Images with duplicate names are invalid" do
    image = Image.new
    image.image_file = File.open("#{Rails.root}/test/fixtures/images/perfect_size.jpg")
    image.save

    image2 = Image.new
    image2.image_file = File.open("#{Rails.root}/test/fixtures/images/perfect_size.jpg")

    image2.valid?
    assert image2.errors[:file_name].any?, 'Image with duplicate name should be invalid'
  end
end
