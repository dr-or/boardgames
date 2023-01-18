class User < ApplicationRecord
  has_many :games
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 40 }
end
