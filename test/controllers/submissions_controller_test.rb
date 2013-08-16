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
    sub = Submission.new
    sub.artist_statement = File.open("#{Rails.root}/test/fixtures/documents/statement.pdf")
    sub.expo_project = File.open("#{Rails.root}/test/fixtures/documents/expo.pdf")
    sub.cv = File.open("#{Rails.root}/test/fixtures/documents/cv.pdf")
    sub.image_list = File.open("#{Rails.root}/test/fixtures/documents/image_list.pdf")
    sub.save

    post :complete, id: sub.id

    submission = Submission.find(sub.id)
    assert_equal true, submission.complete
    assert_redirected_to profile_path

  end
end
