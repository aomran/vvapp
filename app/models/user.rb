class User < ActiveRecord::Base
  has_many :submissions
  # don't validate first_name, so that art groups have a way out
  # similarly don't force gender validation
  # finally, don't force province validation
  validates  :last_name, :email, :phone_number, :street_address, :city, :postal_code, :country, presence: true
  has_secure_password

  def has_submission?
    self.submissions.any?
  end
end
