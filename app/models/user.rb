class User < ApplicationRecord
  has_many :games

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 40 }

  before_validation :set_name

  private

  def set_name
    self.name = "Gamer #{rand(777)}" if self.name.blank?
  end
end
