require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "submissions missing cv or image_list are invalid" do
    sub = Submission.new
    sub.artist_statement = File.open("#{Rails.root}/test/fixtures/documents/statement.pdf")
    sub.expo_project = File.open("#{Rails.root}/test/fixtures/documents/expo.pdf")

    sub.valid?
    assert !sub.errors[:artist_statement].any?, 'should be no error on artist statement'
    assert !sub.errors[:expo_project].any?, 'should be no error on expo project'
    assert sub.errors[:cv].any?, 'submission missing cv should be invalid'
    assert sub.errors[:image_list].any?, 'submission missing image_list should be invalid'
  end
  test "submissions missing project or statement are invalid" do
    sub = Submission.new
    sub.cv = File.open("#{Rails.root}/test/fixtures/documents/cv.pdf")
    sub.image_list = File.open("#{Rails.root}/test/fixtures/documents/image_list.pdf")


    sub.valid?
    assert !sub.errors[:cv].any?, 'should be no error on cv'
    assert !sub.errors[:image_list].any?, 'should be no error on image_list'
    assert sub.errors[:artist_statement].any?, 'submission missing statement should be invalid'
    assert sub.errors[:expo_project].any?, 'submission missing project should be invalid'
  end
end
