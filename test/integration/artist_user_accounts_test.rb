require 'test_helper'

class ArtistUserAccountsTest < Capybara::Rails::TestCase

  test "an artist can signup for an account" do
    visit register_path
    fill_in :user_first_name, with: 'Paula'
    fill_in :user_last_name, with: 'LittlyFrenchy'
    fill_in :user_email, with: 'paula@littlefrance.com'
    fill_in :user_password, with: 'password123'
    fill_in :user_password_confirmation, with: 'password123'
    fill_in :user_phone_number, with: '(819)667-3467'
    fill_in :user_street_address, with: '1234 Something dr.'
    fill_in :user_city, with: 'Gatineau'
    fill_in :user_province, with: 'Quebec'
    fill_in :user_postal_code, with: 'J8G5H6'
    fill_in :user_country, with: 'Quebec'
    choose 'Femme'

    assert_difference 'User.count' do
      click_button 'Inscription'
    end

    assert current_path == profile_path, 'Not redirected to user profile page'
  end

  test "a logged-in artist can edit their profile" do
    login_as(users(:paula))
    assert current_path == profile_path, 'Not redirected to user profile page'

    click_link('Editer profile')
    assert current_path == edit_profile_path, 'Not redirected to user edit profile page'

    fill_in :user_first_name, with: 'PAULA'
    fill_in :user_last_name, with: 'LF'
    fill_in :user_email, with: 'paula@little.com'
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password453'
    fill_in :user_phone_number, with: '(819)667-9967'
    fill_in :user_street_address, with: '99 Something dr.'
    fill_in :user_city, with: 'Batineau'
    fill_in :user_province, with: 'Huebec'
    fill_in :user_postal_code, with: 'A8G5H6'
    fill_in :user_country, with: 'Huebec'
    choose 'Femme'
    click_button 'Inscription'

    assert current_path == profile_path
    user = User.find(users(:paula).id)
    assert user.first_name == 'PAULA', 'First name was not updated'
    assert user.authenticate('password453')
  end

  test "a logged-in artist gets form errors if their profile edits are invalid" do
    login_as(users(:paula))

    click_link('Editer profile')

    fill_in :user_first_name, with: 'PAULA'
    fill_in :user_last_name, with: ''
    fill_in :user_email, with: 'paula@little.com'
    fill_in :user_password, with: 'password453'
    fill_in :user_password_confirmation, with: 'password453'
    fill_in :user_phone_number, with: '(819)667-9967'
    fill_in :user_street_address, with: '99 Something dr.'
    fill_in :user_city, with: 'Batineau'
    fill_in :user_province, with: 'Huebec'
    fill_in :user_postal_code, with: 'A8G5H6'
    fill_in :user_country, with: 'Huebec'
    choose 'Femme'
    click_button 'Inscription'

    assert page.has_content?('Nom de famille manquant')
  end

  test "An artist who forgot their password can get a reset email" do
    visit login_path
    click_link 'password-reset'

    fill_in :email, with: 'paula@Lilfrenchy.com'
    click_button 'password-reset-button'

    assert page.has_content?('Courriel envoyé avec des instructions pour mettre à jour votre mot de passe')

  end
end
