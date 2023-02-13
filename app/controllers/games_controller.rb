class GamesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_game, only: %i[show]
  before_action :set_current_user_game, only: %i[edit update destroy]
  before_action :password_guard!, only: %i[show]

  def index
    @games = Game.all
  end

  def create
    @game = current_user.games.build(game_params)

    if @game.save
      redirect_to game_path(@game), notice: I18n.t('controllers.games.created')
    else
      render :new
    end
  end

  def new
    @game = current_user.games.build(user_id: params[:user_id])
  end

  def edit
  end

  def show
    @new_comment = @game.comments.build(params[:comment])
    @new_subscription = @game.subscriptions.build(params[:subscription])
  end

  def update
    if @game.update(game_params)
      redirect_to game_path(@game), notice: I18n.t('controllers.games.updated')
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to root_path, notice: I18n.t('controllers.games.destroyed')
  end

  private

  def game_params
    params.require(:game).permit(:title, :description, :address, :datetime, :pincode)
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def set_current_user_game
    @game = current_user.games.find(params[:id])
  end

  def password_guard!
    return true if @game.pincode.blank?
    return true if user_signed_in? && @game.user == current_user

    if params[:pincode].present? && @game.pincode == params[:pincode]
      cookies.permanent["game_#{@game.id}_pincode"] = params[:pincode]
    end

    unless @game.pincode == cookies.permanent["game_#{@game.id}_pincode"]
      flash.now[:alert] = I18n.t("controllers.games.wrong_pincode") if params[:pincode].present?
      render "password_form"
    end
  end
end
