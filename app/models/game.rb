class Game < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :subscriptions

  validates :title, presence: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :datetime, presence: true
end
