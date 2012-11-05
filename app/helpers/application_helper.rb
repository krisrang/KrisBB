module ApplicationHelper
  def online_bit(user)
    klass = user.online? ? "pixels-online" : "pixels-offline"
    raw "<i class=\"avatar #{klass}\" rel=\"tooltip\"></i>"
  end

  def icon_text(icon, text)
    raw("<i class=\"icon-#{icon}\"></i>") + " #{text}"
  end

  def avatar(user, type)
    content_tag :i, class: "avatar #{type}" do
      image_tag user.avatar.versions[type]
    end
  end

  def nav_li(title, link)
    active = request.path.start_with? link
    klass = active ? "active" : ""
    content_tag :li, class: klass do
      link_to title, link 
    end
  end

  def render_stats_bar
    render partial: 'shared/stats'
  end

  def bootstrap_cache_key(messages)
    ["bootstrap"].tap do |key|
      key.push messages.first, messages.first.user unless messages.blank?
    end
  end
end
