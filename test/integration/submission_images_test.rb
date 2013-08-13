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

  test "artist can add images to submission" do
    image = "SyntacticSugar.jpg"
    attach_image_as(image, users(:paula))

    assert_difference 'Image.count' do
      click_button 'Déposer soumission'
    end

    user_submission_image = users(:paula).submissions.first.images.second
    assert_equal user_submission_image, Image.last
  end

  test "artist can remove images from submission" do
    image = "SyntacticSugar.jpg"
    attach_image_as(image, users(:paula))
    user_submission = users(:paula).submissions.first
    click_button 'Déposer soumission'

    added_image = Image.last
    assert_difference 'Image.count', -1 do
      within "#image_#{added_image.id}" do
        click_link 'Enlever'
      end
    end
    assert_equal submission_images_path(user_submission), current_path
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
