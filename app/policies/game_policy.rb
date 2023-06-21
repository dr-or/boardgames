class GamePolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    new?
  end

  def destroy?
    host?
  end

  def update?
    destroy?
  end

  def edit?
    destroy?
  end

  def show?
    valid_password?(record)
  end

  private

  def host?
    user.present? && record.try(:user) == user
  end

  def valid_password?(game_context)
    return true if game_context.game.pincode.blank?
    return true if user.present? && record.game.user == user

    game_context.pincode.present? && game_context.game.valid_pincode?(game_context.pincode)
  end
end
