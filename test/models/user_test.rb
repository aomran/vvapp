require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @blank_user = User.new
    @blank_user.invalid?
  end
  test "should check if user has a submission already" do
    user_without_submission = users(:bob)
    user_with_submission = users(:paula)
    assert user_without_submission.has_submission? == false
    assert user_with_submission.has_submission? == true
  end

  test "last_name must not be empty" do
    assert @blank_user.errors[:last_name].any?
  end
  test "email must not be empty" do
    assert @blank_user.errors[:email].any?
  end
  test "phone_number must not be empty" do
    assert @blank_user.errors[:phone_number].any?
  end
  test "street_address must not be empty" do
    assert @blank_user.errors[:street_address].any?
  end
  test "city must not be empty" do
    assert @blank_user.errors[:city].any?
  end
  test "postal_code must not be empty" do
    assert @blank_user.errors[:postal_code].any?
  end
  test "country must not be empty" do
    assert @blank_user.errors[:country].any?
  end

  # test "the truth" do
  #   assert true
  # end
end
