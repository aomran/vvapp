require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get user" do
    get :show, id: users(:paula).id

    assert assigns(:user)
    assert :success
  end

  test "should get list of all users" do
    get :index
    assert assigns(:users), 'Collection of users not passed to view'
    assert :success
  end

  test "should show profile for current user" do
    session[:user_id] = users(:paula).id

    get :profile

    assert assigns(:current_user), 'current user object not assigned to view'
    assert :success
  end
end
