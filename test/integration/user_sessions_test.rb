require 'test_helper'

class UserSessionsTest < Capybara::Rails::TestCase

  test "artists can login" do
    visit login_path

    fill_in 'Courriel', with: users(:paula).email
    fill_in 'Mot de passe', with: 'password123'
    click_button 'Connexion'

    assert page.has_content?('Vous êtes connecté(e) comme paula@Lilfrenchy.com'), 'Email of logged in user is not shown'
    assert current_path == profile_path
  end

  test "artists can't login with wrong password" do
    visit login_path

    fill_in 'Courriel', with: users(:paula).email
    fill_in 'Mot de passe', with: 'wrongpassword'
    click_button 'Connexion'

    assert page.has_content?('Courriel ou mot de passe est invalide.'), 'Error message is not shown'

    assert current_path == login_path
  end

  test "logged in artist can log out" do
    visit logout_path

    assert current_path == root_path, 'Did not redirect to front page'
    assert page.has_content?("Vous êtes désormais déconnecté"), 'Wrong logout notice given'
  end
end
