CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_KEY'],                # required
      :aws_secret_access_key  => ENV['S3_SECRET'],             # required
    }
    config.fog_directory  = 'vv-soumissions'                   # required
    config.fog_public     = false                                   # optional, defaults to true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  elsif Rails.env.development?
    config.storage = :file
  else
    config.storage = :file
  end
end