module ApplicationHelper
  def online_bit(user)
    klass = user.online? ? "pixels-online" : "pixels-offline"
    content_tag :i, class: "avatar #{klass}", rel: "tooltip"
  end

  def avatar(user, type)
    content_tag :i, class: "avatar #{type}" do
      image_tag user.avatar.versions[type]
    end
  end
end
