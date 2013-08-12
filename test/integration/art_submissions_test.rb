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

    attach_file "Fichiers d'Images", "#{Rails.root}/test/fixtures/images/#{image}"
  end


  test "not logged in artist cannot make submissions" do

    visit new_submission_path

    assert current_path == login_path, 'Not at login page'
    assert page.has_content?('Veuillez vous connecter ou vous inscrire avant de faire une soumission de dossier'), 'Notice about logging in or signing up not found'
  end

  test "logged in artist can make a submission" do
    login_as(users(:bob))

    visit new_submission_path
    attach_file "CV", "#{Rails.root}/test/fixtures/documents/cv.pdf"
    attach_file "Démarche", "#{Rails.root}/test/fixtures/documents/statement.pdf"
    attach_file "Projet", "#{Rails.root}/test/fixtures/documents/expo.pdf"
    attach_file "Exigences spéciales (optionelle)", "#{Rails.root}/test/fixtures/documents/special.pdf"
    attach_file "Liste d'Images", "#{Rails.root}/test/fixtures/documents/image_list.pdf"

    assert_difference 'Submission.count' do
      click_button 'Déposer soumission'
    end

    bob_submission = users(:bob).submissions.first

    assert bob_submission.cv_url
    assert bob_submission.artist_statement_url
    assert bob_submission.expo_project_url
    assert bob_submission.special_needs_url
    assert bob_submission.image_list_url

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

    old_file_path = paula_submission.cv_url
    attach_file "CV", "#{Rails.root}/test/fixtures/documents/cv_new.pdf"
    attach_file "Démarche", "#{Rails.root}/test/fixtures/documents/statement_new.pdf"
    attach_file "Projet", "#{Rails.root}/test/fixtures/documents/expo_new.pdf"
    attach_file "Exigences spéciales (optionelle)", "#{Rails.root}/test/fixtures/documents/special_new.pdf"
    attach_file "Liste d'Images", "#{Rails.root}/test/fixtures/documents/image_list_new.pdf"
    click_button 'Enregistrer modifications'

    assert current_path == submission_path(paula_submission), 'Did not go to the show submission page'
    paula_submission = users(:paula).submissions.first

    assert paula_submission.cv_url != old_file_path, 'CV was not updated'

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

  test "artist can finalize submission" do
    login_as(users(:paula))
    click_link 'Continuez Soumission'
    click_link 'Ajoutez Images'
    click_button 'Finalisez Soumission'

    user_submission_id = users(:paula).submissions.first.id
    user_submission = Submission.find(user_submission_id)
    assert_equal true, user_submission.complete, 'The submission is not complete'
    assert_equal profile_path, current_path
    assert page.has_content?('Votre Soumission est complete')
  end


end
