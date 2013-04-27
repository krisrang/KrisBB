class LazyWorkQueue < GirlFriday::WorkQueue
  include Singleton

  def self.define *options, &block
    Class.new LazyWorkQueue do
      define_method :initialize do
        super *options do |info|
          block.call info
        end
      end
    end
  end

  def self.push *args
    instance.push *args
  end

  def self.status
    instance.status
  end

end

EMAIL_QUEUE = GirlFriday::WorkQueue.new :user_email, size: 3 do |info|
  Notifications.new_message(info[:message], info[:email], info[:token]).deliver
end

PUSHER_QUEUE = GirlFriday::WorkQueue.new :pusher, size: 3 do |info|
  Pusher['private-main'].trigger(info[:type], info[:message], info[:socket])
end

# AIRBRAKE_QUEUE = GirlFriday::WorkQueue.new :airbrake, size: 3 do |notice|
#   Airbrake.sender.send_to_airbrake(notice)
# end

# Airbrake.configure do |config|
#   config.async do |notice|
#     AIRBRAKE_QUEUE.push(notice)
#   end
# end
