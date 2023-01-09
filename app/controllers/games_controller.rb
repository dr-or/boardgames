class GamesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_current_user_game, only: %i[edit update destroy]

  def index
    @games = Game.all
  end

  def create
    @game = current_user.games.build(game_params)

    if @game.save
      redirect_to game_path(@game), notice: 'Game is scheduled.'
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
    @game = Game.find(params[:id])
  end

  def update
    if @game.update(game_params)
      redirect_to game_path(@game), notice: 'Changes applied.'
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to root_path, notice: 'Game is canceled.'
  end

  private

  def game_params
    params.require(:game).permit(:title, :description, :address, :datetime)
  end

  def set_current_user_game
    @game = current_user.games.find(params[:id])
  end
end
