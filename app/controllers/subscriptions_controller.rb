class SubscriptionsController < ApplicationController
  before_action :set_game, only: %i[create destroy]
  before_action :set_subscription, only: %i[destroy]

  def create
    @new_subscription = @game.subscriptions.build(subscription_params)
    @new_subscription.user = current_user

    if check_recaptcha(@new_subscription) && @new_subscription.save
      MailingJob.perform_later(@new_subscription)

      redirect_to game_path(@game), notice: I18n.t('controllers.subscriptions.created')
    else
      flash.now[:alert] = I18n.t('controllers.error')
      render 'games/show'
    end
  end

  def destroy
    message = { notice: I18n.t('controllers.subscriptions.destroyed') }

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = { alert: I18n.t('controllers.error') }
    end

    redirect_to game_path(@game), message
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_subscription
    @subscription = @game.subscriptions.find(params[:id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_name, :user_email)
  end

  def check_recaptcha(model)
    current_user.present? || verify_recaptcha(model:)
  end
end
