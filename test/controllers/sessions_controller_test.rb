require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should login user" do
    post :create, { email: users(:paula).email, password: 'password123'}

    assert_equal session[:user_id], users(:paula).id
    assert_redirected_to user_path(users(:paula))
  end
end
