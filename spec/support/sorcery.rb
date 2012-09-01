RSpec.configure do |config|
  config.include Sorcery::TestHelpers::Rails, :type => :controller
end
