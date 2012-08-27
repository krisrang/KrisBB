CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_KEY'],
    :aws_secret_access_key  => ENV['S3_SECRET'],
    :region                 => 'eu-west-1'
  }

  one_year = 31557600
  config.fog_directory  = 'krisbb-assets'
  config.fog_host       = '//krisbb-assets.s3.amazonaws.com'
  config.fog_public     = true
  config.fog_attributes = {cache_control: "public, max-age=#{one_year}",
                           expires: CGI.rfc1123_date(Time.now + one_year)}

  config.delete_tmp_file_after_storage = false if Rails.env.development?
end
