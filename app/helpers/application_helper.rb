module ApplicationHelper
  def flash_class(key)
    case key
    when "notice" then "success"
    when "alert" then "danger"
    end
  end
end
