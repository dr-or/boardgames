class Subscription < ApplicationRecord
  belongs_to :game
  belongs_to :user, optional: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: { scope: :game_id }
    validate :organizer_cant_be_subscriber
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true, format: { with: /\A[\w\-.]+@[\w\-.]+\z/ }
    validates :user_email, uniqueness: { scope: :game_id }
    validate :registered_email
  end

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def organizer_cant_be_subscriber
    errors.add(:user, :forbidden) if user == game&.user
  end

  def registered_email
    errors.add(:user_email, :taken) if User.exists?(email: user_email&.downcase)
  end
end
