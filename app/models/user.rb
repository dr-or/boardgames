class User < ApplicationRecord
  has_many :games
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_many :photos, dependent: :destroy

  after_commit :link_subscriptions, on: :create

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 40 }

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update(user_id: self.id)
  end
end
