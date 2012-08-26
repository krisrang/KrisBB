module ApplicationHelper
  def online_bit(user)
    time = user.last_activity_at || 1000.years.ago
    img = time > 15.minutes.ago ?
      "online.png" :
      "offline.png"

    image_tag img, title: "Last seen " + time_ago_in_words(time) + " ago",
      class: "online-bit"
  end

  def avatar(user, type)
    content_tag :i, class: "avatar #{type}" do
      image_tag user.avatar.versions[type]
    end
  end
end
