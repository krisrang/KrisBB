module ApplicationHelper
  def render_flash
    render partial: 'shared/flash', locals: { flash: flash }
  end
end
