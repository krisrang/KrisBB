worker_processes 3
timeout 30
preload_app true
port = ENV["PORT"].to_i
listen port#, tcp_nopush: false

before_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    Resque.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end

  sleep 1
end

after_fork do |server, worker|
  require 'action_dispatch/middleware/session/dalli_store'

  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  if defined?(Resque)
    Resque.redis = ENV['REDIS_URI']
    Rails.logger.info('Connected to Redis')
  end

  if defined?(ActiveSupport::Cache::DalliStore) && Rails.cache.is_a?(ActiveSupport::Cache::DalliStore)
    # Reset Rails's object cache
    # Only works with DalliStore
    Rails.cache.reset

    # Reset Rails's session store
    # If you know a cleaner way to find the session store instance, please let me know
    ObjectSpace.each_object(ActionDispatch::Session::DalliStore) { |obj| obj.reset }
  end

  if defined?(EventMachine)
    Thread.new { EM.stop; EM.run }
  end
end
