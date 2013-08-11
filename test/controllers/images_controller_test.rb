require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  test "should add image to submission" do
    session[:user_id] = users(:paula).id
    submission = users(:paula).submissions.first
    post :create, image: {image_file: 'art.jpg'}, submission_id: submission.id

    assert_equal submission.images.size, 1
    assert_redirected_to submission_path(submission)
  end

end
