require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "submissions missing cv or image_list are invalid" do
    sub = Submission.new
    uploader1 = DocumentUploader.new(sub, :artist_statement)
    uploader2 = DocumentUploader.new(sub, :expo_project)

    uploader1.store!(File.open("#{Rails.root}/test/fixtures/documents/statement.pdf"))
    uploader2.store!(File.open("#{Rails.root}/test/fixtures/documents/expo.pdf"))


    sub.valid?
    assert sub.errors[:cv].any?, 'submission missing cv should be invalid'
    assert sub.errors[:image_list].any?, 'submission missing image_list should be invalid'
  end
  test "submissions missing project or statement are invalid" do
    sub = Submission.new
    uploader1 = DocumentUploader.new(sub, :cv)
    uploader2 = DocumentUploader.new(sub, :image_list)

    uploader1.store!(File.open("#{Rails.root}/test/fixtures/documents/cv.pdf"))
    uploader2.store!(File.open("#{Rails.root}/test/fixtures/documents/image_list.pdf"))


    sub.valid?
    assert sub.errors[:artist_statement].any?, 'submission missing statement should be invalid'
    assert sub.errors[:expo_project].any?, 'submission missing project should be invalid'
  end
end
