require 'test_helper'

class AnnualSubmissionsControllerTest < ActionController::TestCase
  test "should create annual submission for artist" do
    session[:user_id] = users(:paula).id
    post :create, annual_submission: {cv: 'cv.pdf', artist_statement: 'statement.pdf', expo_project: 'expo.pdf', special_needs: 'special.pdf', image_list: 'image_list.pdf'}
    assert assigns(:user)

    assert_equal users(:paula).annual_submissions.size, 2
  end

  test "should get list of all submissions" do
    get :index
    assert assigns(:annual_submissions)
    assert :success
  end

  test "should get single submission" do
    get :show, id: annual_submissions(:one).id
    assert :success
    assert assigns(:annual_submission)
  end
end
