require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get user" do
    get :show, id: users(:paula).id

    assert assigns(:user)
    assert :success
  end
end
