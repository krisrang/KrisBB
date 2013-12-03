CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      :region                 => 'us-east-1'
    }

    one_year = 31557600
    config.asset_host     = Settings.assethost.production
    config.fog_directory  = 'kreu-krisbb-assets'
    config.fog_public     = true
    config.fog_attributes = {cache_control: "public, max-age=#{one_year}",
                             expires: CGI.rfc1123_date(Time.now + one_year)}
  elsif Rails.env.test?
    config.storage = :file
    config.root = "#{Rails.root}/tmp/carrierwave"
    config.cache_dir = "carrierwave"
  end
end