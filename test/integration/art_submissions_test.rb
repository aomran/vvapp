require 'test_helper'

class ArtSubmissionsTest < Capybara::Rails::TestCase

  def login_as(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Log In'
  end


  test "not logged in artist cannot make submissions" do

    visit new_submission_path

    assert current_path == login_path, 'Not at login page'
    assert page.has_content?('Please signup or login before making an art submission'), 'Notice about logging in or signing up not found'
  end

  test "logged in artist can make a submission" do
    login_as(users(:bob))

    visit new_submission_path
    fill_in "CV", with: 'cv.pdf'
    fill_in "Artist Statement", with: 'artist_statement.pdf'
    fill_in "Expo Project", with: 'expo_project.pdf'
    fill_in "Special Needs", with: 'special_needs.pdf'
    fill_in "Image List", with: 'image_list.pdf'


    assert_difference 'Submission.count' do
      click_button 'Create Submission'
    end

    assert page.has_content?("Your Submission has been received!"), 'Notice about submission received not shown'

    assert_equal users(:bob).submissions.last, Submission.last
  end

  test "artist can not make more than one submission" do
    login_as(users(:paula))

    visit new_submission_path
    assert current_path == profile_path, 'Not redirected to their profile page'
    assert page.has_content?("You have already made a submission"), 'Error message is not given'
  end
end
