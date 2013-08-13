require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  test "should add image to submission" do
    session[:user_id] = users(:paula).id
    submission = users(:paula).submissions.first
    post :create, image: {image_file: 'art.jpg'}, submission_id: submission.id

    assert_equal submission.images.size, 2
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
