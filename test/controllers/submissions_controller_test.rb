require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase
  def setup
    session[:user_id] = users(:bob).id
  end

  test "should create submission for artist" do
    post :create, submission: {
      cv: 'cv.pdf', artist_statement: 'statement.pdf', expo_project: 'expo.pdf', special_needs: 'special.pdf', image_list: 'image_list.pdf'
    }
    assert assigns(:user)
    assert_equal assigns(:user).submissions.size, 1
  end

  test "should get list of all submissions" do
    get :index
    assert assigns(:submissions)
    assert :success
  end

  test "should get single submission" do
    get :show, id: submissions(:one).id
    assert :success
    assert assigns(:submission)
  end

  test "should set submission as complete" do
    post :complete, id: submissions(:one).id

    submission = Submission.find(submissions(:one).id)
    assert_equal true, submission.complete
    assert_redirected_to profile_path

  end
end
