module ApplicationHelper
  def render_flash
    render partial: 'shared/flash', locals: { flash: flash }
  end

  def online_bit(user)
    time = user.last_activity_at || 1000.years.ago
    img = time > 15.minutes.ago ?
      "online.png" :
      "offline.png"
    
    image_tag img, title: "Last seen " + time_ago_in_words(time) + " ago", class: "online-bit"
  end
end
