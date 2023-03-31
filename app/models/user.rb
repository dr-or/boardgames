class User < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  after_commit :link_subscriptions, on: :create

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [100, 100]
    attachable.variant :small, resize_to_limit: [200, 200]
  end

  validates :name, presence: true, length: { maximum: 40 }
  validates :avatar, content_type: ['image/png', 'image/jpeg', 'image/jpg'],
            size: { less_than: 1.megabyte }
  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update(user_id: self.id)
  end
end
