class GameMailer < ApplicationMailer

  def comment(comment, game, email)
    @comment = comment
    @game = game

    mail to: email, subject: "#{I18n.t("game_mailer.comment.subject")} #{game.title}"
  end

  def photo(game, email, photo)
    @game = game
    @photo = photo

    mail to: email, subject: "#{I18n.t("game_mailer.photo.subject")} #{game.title}"
  end
  
  def subscription(game, subscription)
    @game = game
    @email = subscription.user_email
    @name = subscription.user_name

    mail to: game.user.email, subject: "#{I18n.t("game_mailer.subscription.subject")} #{game.title}"
  end
end
