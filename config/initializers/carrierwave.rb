CarrierWave.configure do |config|
  if Rails.env.production?
    config.asset_host = Settings.assethost.production
  elsif Rails.env.test?
    if ENV['TDDIUM']
      config.root = Dir.tmpdir
      config.cache_dir = "carrierwave"
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
