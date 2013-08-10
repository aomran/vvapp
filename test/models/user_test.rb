require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should check if user has a submission already" do
    user_without_submission = users(:bob)
    user_with_submission = users(:paula)
    assert user_without_submission.has_submission? == false
    assert user_with_submission.has_submission? == true
  end
  # test "the truth" do
  #   assert true
  # end
end
