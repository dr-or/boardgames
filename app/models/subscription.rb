class Subscription < ApplicationRecord
  belongs_to :game
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true,
            format: { with: /\A[\w\-.]+@[\w\-.]+\z/ },
            unless: -> { user.present? }

  validates :user, uniqueness: {scope: :game_id}, if: -> { user.present? }
  validates :user_email, uniqueness: {scope: :game_id}, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end
end
