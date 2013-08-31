require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should send the password reset" do
    post :create, email: 'paula@Lilfrenchy.com'
    assert_equal users(:paula), assigns(:user)
    assert_respond_to(assigns(:user), :send_password_reset)
    assert_redirected_to login_path
  end

end
