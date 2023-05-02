class GamePolicy < ApplicationPolicy
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end

  def destroy?
    user.games.include?(@game)
  end

  def update?
    destroy?
  end

  def edit?
    super
  end

  def show?
    true
  end
end
