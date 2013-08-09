require 'test_helper'

class ArtistUserAccountsTest < Capybara::Rails::TestCase

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

end
