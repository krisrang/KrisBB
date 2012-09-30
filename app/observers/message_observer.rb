class MessageObserver < Mongoid::Observer
  observe :message

  def after_create(message)
    expire_cache_for(message)
  end

  def after_update(message)
    expire_cache_for(message)
  end

  def after_destroy(message)
    expire_cache_for(message)
  end

  private
  def expire_cache_for(message)
    @cont ||= ActionController::Base.new
    @cont.expire_fragment("bootstrap")
  end
end
