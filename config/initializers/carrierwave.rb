CarrierWave.configure do |config|
  if Rails.env.production? || Rails.env.development?
    config.storage :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET'],
      :region                 => 'eu-west-1'
    }

    one_year = 31557600
    config.fog_directory  = 'krisbb-assets'
    config.fog_host       = Settings.assethost.fog
    config.fog_public     = true
    config.fog_attributes = {cache_control: "public, max-age=#{one_year}",
                             expires: CGI.rfc1123_date(Time.now + one_year)}
  elsif Rails.env.test?
    if ENV['TDDIUM']
      config.storage = :file
      config.root = Dir.tmpdir
      config.cache_dir = "carrierwave"
    else
      config.storage = :file
      #config.delete_tmp_file_after_storage = false
      #config.enable_processing = false
    end
  end
end

module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end
