CarrierWave.configure do |config|
  if Rails.env.test? && ENV['TDDIUM']
    config.root = Dir.tmpdir
    config.cache_dir = "carrierwave"
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
