require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should create session" do
    post :create, { email: users(:paula).email, password: 'password123'}

    assert_equal session[:user_id], users(:paula).id
    assert_redirected_to user_path(users(:paula))
  end

  test "should destroy session" do
    session[:user_id] = 1
    get :destroy
    assert_equal session[:user_id], nil
  end
end
