require 'test_helper'

class ArtSubmissionsTest < Capybara::Rails::TestCase

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
      click_button 'Submit_submission'
    end

    bob_submission = users(:bob).submissions.first

    assert bob_submission.cv_url
    assert bob_submission.artist_statement_url
    assert bob_submission.expo_project_url
    assert bob_submission.special_needs_url
    assert bob_submission.image_list_url

    assert_equal bob_submission, Submission.last

    assert current_path == submission_path, 'Was not redirected to Bob submission page'
    assert page.has_content?("Vos documents ont été reçus!"), 'Notice about submission received not shown'
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

    click_link 'link-Continue_Sub'
    assert current_path == submission_path, 'Did not go to the submission show page'

    click_link 'link-Edit_Sub'
    assert current_path == edit_submission_path, 'Did not go to the submission edit page'

    old_file_path = paula_submission.cv_url
    attach_file "CV", "#{Rails.root}/test/fixtures/documents/cv_new.pdf"
    attach_file "Démarche", "#{Rails.root}/test/fixtures/documents/statement_new.pdf"
    attach_file "Projet", "#{Rails.root}/test/fixtures/documents/expo_new.pdf"
    attach_file "Exigences spéciales (optionelle)", "#{Rails.root}/test/fixtures/documents/special_new.pdf"
    attach_file "Liste d'Images", "#{Rails.root}/test/fixtures/documents/image_list_new.pdf"
    click_button 'Submit_submission'

    assert current_path == submission_path, 'Did not go to the show submission page after edit'
    paula_submission = users(:paula).submissions.first

    assert paula_submission.cv_url != old_file_path, 'CV was not updated'

    assert find_link('link-Edit_Sub').visible?
  end

end
