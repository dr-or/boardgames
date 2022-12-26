class Game < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :datetime, presence: true
end
