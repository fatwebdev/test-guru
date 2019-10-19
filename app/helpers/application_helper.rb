module ApplicationHelper
  ALERTS = { alert: 'danger', notice: 'primary' }.freeze

  def flash_message
    flash.map do |type, msg|
      content_tag :div, msg, class: "alert alert-#{ALERTS[type.to_sym]}", role: "alert"
    end.join.html_safe
  end
end
