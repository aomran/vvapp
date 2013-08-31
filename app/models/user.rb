class User < ActiveRecord::Base
  has_many :submissions
  # don't validate first_name, so that art groups have a way out
  # similarly don't force gender validation
  # finally, don't force province validation
  validates  :last_name, :email, :phone_number, :street_address, :city, :postal_code, :country, presence: true
  validates :email, uniqueness: true

  has_secure_password

  def has_submission?
    self.submissions.any?
  end

  def recent_submission
    self.submissions.last
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
