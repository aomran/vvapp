require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase
  test "should create submission for artist" do
    session[:user_id] = users(:paula).id
    post :create, submission: {cv: 'cv.pdf', artist_statement: 'statement.pdf', expo_project: 'expo.pdf', special_needs: 'special.pdf', image_list: 'image_list.pdf'}
    assert assigns(:user)

    assert_equal users(:paula).submissions.size, 2
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
end
