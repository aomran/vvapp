class User < ActiveRecord::Base
  has_many :annual_submissions
  has_secure_password
end
