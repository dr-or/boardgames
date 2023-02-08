class CommentsController < ApplicationController
  before_action :set_game, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  def create
    @new_comment = @game.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      notify_subscribers(@game, @new_comment)
      redirect_to game_path(@game), notice: I18n.t("controllers.comments.created")
    else
      flash.now[:alert] = I18n.t("controllers.error")
      render "games/show"
    end
  end

  def destroy
    message = {notice: I18n.t("controllers.comments.destroyed")}

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = {alert: I18n.t("controllers.error")}
    end

    redirect_to game_path(@game), message
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_comment
    @comment = @game.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end

  def notify_subscribers(game, comment)
    all_emails = (game.subscriptions.map(&:user_email) + [game.user.email]).uniq

    all_emails.each do |email|
      GameMailer.comment(comment, email).deliver_now
    end
  end
end
