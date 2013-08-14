require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  test "should add image to submission" do
    session[:user_id] = users(:paula).id
    submission = users(:paula).submissions.first

    image_file = Rack::Test::UploadedFile.new(File.open("#{Rails.root}/test/fixtures/images/perfect_size.jpg"))

    post :create, image: {image_file: image_file}, submission_id: submission.id

    assert_equal 2, submission.images.size
    assert_redirected_to submission_images_path(submission)
  end

  test "should delete an image" do
    session[:user_id] = users(:paula).id
    submission = users(:paula).submissions.first
    image = submission.images.first

    assert_difference 'Image.count', -1 do
      delete :destroy, submission_id: submission.id, id: image.id
    end

    assert_redirected_to submission_images_path(submission)
  end

end
