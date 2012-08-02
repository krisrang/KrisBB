CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_KEY'],
    :aws_secret_access_key  => ENV['S3_SECRET'],
    :region                 => 'eu-west-1'
  }
  config.fog_directory  = 'assets.forum.kristjanrang.eu'
  config.fog_host       = 'http://assets.forum.kristjanrang.eu'
  config.fog_public     = true
  #config.fog_attributes = {'Cache-Control' => 'max-age=315576000'}

  config.delete_tmp_file_after_storage = false if Rails.env.development?
end