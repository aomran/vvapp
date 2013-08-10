class User < ActiveRecord::Base
  has_many :submissions
  has_secure_password

  def has_submission?
    self.submissions.any?
  end
end
