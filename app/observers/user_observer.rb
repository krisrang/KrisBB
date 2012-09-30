class UserObserver < Mongoid::Observer
  observe :user

  def after_create(user)
    expire_cache_for(user)
  end

  def after_update(user)
    expire_cache_for(user)
  end

  def after_destroy(user)
    expire_cache_for(user)
  end

  private
  def expire_cache_for(user)
    @cont ||= ActionController::Base.new
    @cont.expire_fragment("bootstrap")
    user.messages.only(:id).map(&:id).each do |id|
      @cont.expire_fragment("message-#{id}")
    end
  end
end
