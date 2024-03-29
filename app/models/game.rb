class Game < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  validates :title, presence: true, length: { maximum: 100 }
  validates :address, presence: true
  validates :datetime, presence: true

  def visitors
    (subscribers.with_attached_avatar + [user]).uniq
  end

  def valid_pincode?(code)
    pincode == code
  end
end
