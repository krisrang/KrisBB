module ApplicationHelper
  def online_bit(user)
    time = user.last_activity_at || 1.years.ago
    klass = time > 15.minutes.ago ?
      "pixels-online" :
      "pixels-offline"

    raw "<i class=\"#{klass} online-bit\" rel=\"tooltip\" title=\"Last seen #{time_ago_in_words(time)} ago\"></i>"
  end

  def avatar(user, type)
    content_tag :i, class: "avatar #{type}" do
      image_tag user.avatar.versions[type]
    end
  end
end
