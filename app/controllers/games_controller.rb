class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  def index
    @games = Game.all
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to game_path(@game), notice: 'Game is scheduled.'
    else
      render :new
    end
  end

  def new
    @game = Game.new
  end

  def edit
  end

  def show
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
    params.require(:game).permit(:title, :description, :address, :datetime, :user_id)
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
