require 'test_helper'

class ArtistUserAccountsTest < Capybara::Rails::TestCase

  def login_as(user)
    visit login_path
    fill_in 'Courriel', with: user.email
    fill_in 'Mot de passe', with: 'password123'
    click_button 'Connexion'
  end

  test "an artist can signup for an account" do
    visit register_path
    fill_in 'Prénom', with: 'Paula'
    fill_in 'Nom de famille', with: 'LittlyFrenchy'
    fill_in 'Courriel', with: 'paula@littlefrance.com'
    fill_in 'Mot de passe', with: 'password123'
    fill_in 'Confirmez mot de passe', with: 'password123'
    fill_in 'Numéro de téléphone', with: '(819)667-3467'
    fill_in 'Adresse de rue', with: '1234 Something dr.'
    fill_in 'Ville', with: 'Gatineau'
    fill_in 'Province', with: 'Quebec'
    fill_in 'Code Postal', with: 'J8G5H6'
    fill_in 'Pays', with: 'Quebec'
    fill_in 'Femme/Homme radio', with: 'Female'

    assert_difference 'User.count' do
      click_button 'Inscrivez-vous'
    end

    assert current_path == profile_path, 'Not redirected to user profile page'
  end

  test "a logged-in artist can edit their profile" do
    login_as(users(:paula))
    assert current_path == profile_path, 'Not redirected to user profile page'

    click_link('Editer profile')
    assert current_path == edit_profile_path, 'Not redirected to user edit profile page'

    fill_in 'Prénom', with: 'PAULA'
    fill_in 'Nom de famille', with: 'LF'
    fill_in 'Courriel', with: 'paula@little.com'
    fill_in 'Mot de passe', with: 'password453'
    fill_in 'Confirmez mot de passe', with: 'password453'
    fill_in 'Numéro de téléphone', with: '(819)667-9967'
    fill_in 'Adresse de rue', with: '99 Something dr.'
    fill_in 'Ville', with: 'Batineau'
    fill_in 'Province', with: 'Huebec'
    fill_in 'Code Postal', with: 'A8G5H6'
    fill_in 'Pays', with: 'Huebec'
    fill_in 'Femme/Homme radio', with: 'Femme'
    click_button 'Enregistrer modifications'

    assert current_path == profile_path
    user = User.find(users(:paula).id)
    assert user.first_name == 'PAULA', 'First name was not updated'
  end
end
