module ApplicationHelper
  def bi_icon(icon_class)
    content_tag(:i, '', class: "bi bi-#{icon_class}")
  end

  def flash_class(key)
    case key
    when "notice" then "success"
    when "alert" then "danger"
    end
  end

  def game_photo(game)
    photos = game.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path("game.jpg")
    end
  end

  def user_avatar(user)
    if user.avatar.attached?
      user.avatar.variant(:small)
    else
      asset_path("no_avatar.jpeg")
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_path("no_avatar.jpeg")
    end
  end
end
