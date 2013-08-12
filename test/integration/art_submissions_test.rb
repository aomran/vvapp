require 'test_helper'

class ArtSubmissionsTest < Capybara::Rails::TestCase

  def login_as(user)
    visit login_path
    fill_in 'Courriel', with: user.email
    fill_in 'Mot de passe', with: 'password123'
    click_button 'Connexion'
  end

  def attach_image_as(image, user_with_submission)
    user_submission = user_with_submission.submissions.first
    login_as(user_with_submission)

    click_link 'Continuez Soumission'
    assert_equal submission_path(user_submission), current_path

    click_link 'Ajoutez Images'
    assert current_path == submission_images_path(user_submission)

    attach_file "Fichiers d'Images", "#{Rails.root}/test/fixtures/#{image}"
  end


  test "not logged in artist cannot make submissions" do

    visit new_submission_path

    assert current_path == login_path, 'Not at login page'
    assert page.has_content?('Veuillez vous connecter ou vous inscrire avant de faire une soumission de dossier'), 'Notice about logging in or signing up not found'
  end

  test "logged in artist can make a submission" do
    login_as(users(:bob))

    visit new_submission_path
    fill_in "CV", with: 'cv.pdf'
    fill_in "Démarche", with: 'artist_statement.pdf'
    fill_in "Projet", with: 'expo_project.pdf'
    fill_in "Exigences spéciales (optionelle)", with: 'special_needs.pdf'
    fill_in "Liste d'Images", with: 'image_list.pdf'


    assert_difference 'Submission.count' do
      click_button 'Déposer soumission'
    end

    bob_submission = users(:bob).submissions.first
    assert_equal bob_submission, Submission.last

    assert current_path == submission_path(bob_submission), 'Was not redirected to Bob submission page'
    assert page.has_content?("Votre soumission a été reçu!"), 'Notice about submission received not shown'
  end

  test "artist can not make more than one submission" do
    login_as(users(:paula))

    visit new_submission_path
    assert current_path == profile_path, 'Not redirected to their profile page'
    assert page.has_content?("Vous avez déjà une soumission"), 'Error message is not given'
  end

  test "artist can edit their submission" do
    login_as(users(:paula))
    paula_submission = users(:paula).submissions.first

    click_link 'Continuez Soumission'
    assert current_path == submission_path(paula_submission), 'Did not go to the submission show page'

    click_link 'Editez Soumission'
    assert current_path == edit_submission_path(paula_submission), 'Did not go to the submission edit page'

    fill_in "CV", with: 'cv_new.pdf'
    fill_in "Démarche", with: 'artist_statement_new.pdf'
    fill_in "Projet", with: 'expo_project_new.pdf'
    fill_in "Exigences spéciales (optionelle)", with: 'special_needs_new.pdf'
    fill_in "Liste d'Images", with: 'image_list_new.pdf'
    click_button 'Enregistrer modifications'

    assert current_path == submission_path(paula_submission), 'Did not go to the show submission page'
    paula_submission = users(:paula).submissions.first
    assert paula_submission.cv == 'cv_new.pdf', 'CV was not updated'

    assert find_link('Editez Soumission').visible?
  end

  test "artist can add images to submission" do
    image = "SyntacticSugar.jpg"
    attach_image_as(image, users(:paula))

    assert_difference 'Image.count' do
      click_button 'Déposer soumission'
    end

    user_submission_image = users(:paula).submissions.first.images.first
    assert_equal user_submission_image, Image.last
  end

  test "artist can see submission images on show page" do
    image = "SyntacticSugar.jpg"
    attach_image_as(image, users(:paula))
    user_submission = users(:paula).submissions.first
    click_button 'Déposer soumission'

    assert_equal submission_images_path(user_submission), current_path
    assert page.has_xpath?("//img[contains(@src, \"#{image}\")]"), 'image not found on show page'
  end


end
