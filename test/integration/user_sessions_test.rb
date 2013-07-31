require 'test_helper'

class UserSessionsTest < Capybara::Rails::TestCase
  test "artists can signup for accounts" do
    visit register_path
    fill_in 'First name', with: 'Paula'
    fill_in 'Last name', with: 'LittlyFrenchy'
    fill_in 'Email', with: 'paula@littlefrance.com'
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
  end
end
