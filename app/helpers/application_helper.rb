module ApplicationHelper
  def flash_message
    flash.map do |type, msg|
      content_tag :p, msg, class: "flash #{type}"
    end.join.html_safe
  end
end
