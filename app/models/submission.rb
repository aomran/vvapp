class Submission < ActiveRecord::Base
  belongs_to :user
  has_many :images
  validates :cv, :image_list, :expo_project, :artist_statement, presence: true

  mount_uploader :cv, DocumentUploader
  mount_uploader :artist_statement, DocumentUploader
  mount_uploader :expo_project, DocumentUploader
  mount_uploader :special_needs, DocumentUploader
  mount_uploader :image_list, DocumentUploader
end
