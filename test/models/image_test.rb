require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "non jpeg/jpg images are not stored" do
    image = Image.new
    uploader = ImageUploader.new(image, :image_file)

    assert_raises CarrierWave::IntegrityError do
    uploader.store!(File.open("#{Rails.root}/test/fixtures/images/not_a_jpg.png"))
    end
  end
end
