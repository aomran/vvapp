require 'test_helper'

class ArtistUserAccountsTest < Capybara::Rails::TestCase

  test "an artist can signup for an account" do
    visit register_path
    fill_in 'First name', with: 'Paula'
    fill_in 'Last name', with: 'LittlyFrenchy'
    fill_in 'Email', with: 'paula@littlefrance.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    fill_in 'Gender', with: 'Female'
    fill_in 'Phone number', with: '(819)667-3467'
    fill_in 'Street address', with: '1234 Something dr.'
    fill_in 'City', with: 'Gatineau'
    fill_in 'Province', with: 'Quebec'
    fill_in 'Postal code', with: 'J8G5H6'
    fill_in 'Country', with: 'Quebec'

    assert_difference 'User.count' do
      click_button 'Create User'
    end

    user = User.last
    assert current_path == user_path(user), 'Not redirected to user profile page'
  end

end
