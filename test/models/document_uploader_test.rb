require 'test_helper'

class DocumentUploaderTest < ActiveSupport::TestCase
  test "non pdf/doc documents are not stored" do
    Fog.mock!
    submission = Submission.new
    uploader = DocumentUploader.new(submission, :cv)

    assert_raises CarrierWave::IntegrityError do
      uploader.store!(File.open("#{Rails.root}/test/fixtures/documents/typeTest.pages"))
    end

    assert_nothing_raised CarrierWave::IntegrityError do
      uploader.store!(File.open("#{Rails.root}/test/fixtures/documents/typeTest.pdf"))
    end

    assert_nothing_raised CarrierWave::IntegrityError do
      uploader.store!(File.open("#{Rails.root}/test/fixtures/documents/typeTest.doc"))
    end
  end
end