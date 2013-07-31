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

  test "artists can't login with wrong password" do
    visit login_path

    fill_in 'Email', with: users(:paula).email
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log In'

    assert page.has_content?('Email or password is invalid.'), 'Error message is not shown'

    assert current_path == login_path
  end

  test "logged in artist can log out" do
    visit logout_path

    assert current_path == users_path, 'Did not redirect to users index view'
    assert page.has_content?("Logged out!"), 'No logout notice given'
  end
end
