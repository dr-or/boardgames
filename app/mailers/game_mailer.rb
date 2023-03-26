class GameMailer < ApplicationMailer

  def comment(comment, email)
    @comment = comment
    @game = comment.game

    mail to: email, subject: default_i18n_subject(title: @game.title)
  end

  def photo(photo, email)
    @game = photo.game
    @photo = photo

    mail to: email, subject: default_i18n_subject(title: @game.title)
  end
  
  def subscription(subscription)
    @game = subscription.game
    @email = subscription.user_email
    @name = subscription.user_name

    mail to: @game.user.email, subject: default_i18n_subject(title: @game.title)
  end
end
