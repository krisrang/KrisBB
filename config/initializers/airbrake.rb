Airbrake.configure do |config|
  config.api_key     = ENV['AIRBRAKE_API_KEY']
  config.port        = 80
  config.secure      = config.port == 443
  config.user_attributes = [:id, :username]
end
