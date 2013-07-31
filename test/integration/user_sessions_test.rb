require 'test_helper'

class UserSessionsTest < Capybara::Rails::TestCase

  test "artists can login" do
    visit login_path

    fill_in 'Email', with: users(:paula).email
    fill_in 'Password', with: 'password123'
    click_button 'Log In'

    assert page.has_content?('You are logged in as paula@Lilfrenchy.com'), 'Email of logged in user is not shown'
    assert current_path == user_path(users(:paula))
  end
end
