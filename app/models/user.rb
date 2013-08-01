class User < ActiveRecord::Base
  has_many :submissions
  has_secure_password
end
