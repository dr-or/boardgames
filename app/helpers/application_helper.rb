module ApplicationHelper
  def flash_class(key)
    case key
    when "notice" then "success"
    when "alert" then "danger"
    end
  end

  def bi_icon(icon_class)
    content_tag(:i, '', class: "bi bi-#{icon_class}")
  end
end
