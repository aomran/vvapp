require 'test_helper'

class SubmissionImagesTest < Capybara::Rails::TestCase

  def attach_image_as(image, user_with_submission)
    user_submission = user_with_submission.submissions.first
    login_as(user_with_submission)

    click_link 'link-Continue_Sub'
    assert_equal submission_path, current_path

    click_link 'link-Add_Images'
    assert current_path == submission_images_path

    attach_file "Fichiers d'images", "#{Rails.root}/test/fixtures/images/#{image}"
  end

  test "artist can add images to submission" do
    image = "SyntacticSugar.jpg"
    attach_image_as(image, users(:paula))

    assert_difference 'Image.count' do
      click_button 'btn-Submit_Sub'
    end

    user_submission_image = users(:paula).submissions.first.images.second
    assert_equal user_submission_image, Image.last
  end

  test "artist can remove images from submission" do
    image = "SyntacticSugar.jpg"
    attach_image_as(image, users(:paula))
    user_submission = users(:paula).submissions.first
    click_button 'btn-Submit_Sub'

    added_image = Image.last
    assert_difference 'Image.count', -1 do
      within "#image_#{added_image.id}" do
        click_link 'link-Remove_Image'
      end
    end
    assert_equal submission_images_path, current_path
  end

  test "artist can see submission images on show page" do
    image = "SyntacticSugar.jpg"
    attach_image_as(image, users(:paula))
    user_submission = users(:paula).submissions.first
    click_button 'btn-Submit_Sub'

    assert_equal submission_images_path, current_path
    assert page.has_xpath?("//img[contains(@src, \"#{image}\")]"), 'image not found on show page'
  end

  test "artist can finalize submission" do
    set_real_submission(users(:bob))
    login_as(users(:bob))
    click_link 'link-Continue_Sub'
    click_link 'link-Add_Images'
    click_button 'btn-Finalize_Sub'


    user_submission = Submission.find(@sub)
    assert_equal true, user_submission.complete, 'The submission is not complete'
    assert_equal profile_path, current_path
    assert page.has_content?('Votre Soumission est complete')
  end

end
