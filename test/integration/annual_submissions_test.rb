require 'test_helper'

class AnnualSubmissionsTest < Capybara::Rails::TestCase
  test "artist can make an annual submission" do
    visit new_annual_submission_path
    fill_in "CV", with: 'cv.pdf'
    fill_in "Artist Statement", with: 'artist_statement.pdf'
    fill_in "Expo Project", with: 'expo_project.pdf'
    fill_in "Special Needs", with: 'special_needs.pdf'
    fill_in "Image List", with: 'image_list.pdf'


    assert_difference 'AnnualSubmission.count' do
      click_button 'Create Annual submission'
    end

    assert page.has_content?("Your Submission has been received!"), 'Notice about submission received not shown'
  end
end
