class GamesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_game, only: %i[edit show update destroy]
  after_action :verify_authorized, only: %i[edit show update destroy]

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
    authorize @game
  end

  def show
    if params[:pincode].present? && @game.valid_pincode?(params[:pincode])
      cookies.permanent["game_#{@game.id}_pincode"] = params[:pincode]
    end

    game_context = GameContext.new(@game, cookies.permanent["game_#{@game.id}_pincode"])
    authorize game_context, policy_class: GamePolicy

    @new_comment = @game.comments.build(params[:comment])
    @new_subscription = @game.subscriptions.build(params[:subscription])
  rescue Pundit::NotAuthorizedError
    flash.now[:alert] = I18n.t("controllers.games.wrong_pincode") if params[:pincode].present?
    render "password_form"
  end

  def update
    authorize @game
    if @game.update(game_params)
      redirect_to game_path(@game), notice: I18n.t('controllers.games.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @game
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
end
