require 'test_helper'

class AnnualSubmissionsTest < Capybara::Rails::TestCase
  test "artist can make an annual submission" do
    visit new_annual_submission_path
    fill_in :cv, with: 'cv.pdf'
    fill_in :artist_statement, with: 'artist_statement.pdf'
    fill_in :cv, with: 'expo_project.pdf'
    fill_in :cv, with: 'special_needs.pdf'
    fill_in :cv, with: 'image_list.pdf'


    assert_difference 'AnnualSubmission.count' do
      click_button 'Submit'
    end

    assert page.has_content?("Your Submission has been received!")
  end
end
