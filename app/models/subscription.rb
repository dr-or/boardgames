class Subscription < ApplicationRecord
  belongs_to :game
  belongs_to :user, optional: true

  with_options if: -> { user.present? } do
    validates :user, uniqueness: {scope: :game_id}
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email, presence: true,
              format: { with: /\A[\w\-.]+@[\w\-.]+\z/ }
    validates :user_email, uniqueness: {scope: :game_id}
  end

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end
end
