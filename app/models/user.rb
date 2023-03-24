class User < ApplicationRecord
  has_many :games
  has_many :comments, dependent: :destroy
  has_many :subscriptions
  has_many :photos, dependent: :destroy

  after_commit :link_subscriptions, on: :create

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :small, resize_to_limit: [200, 200]
  end

  validates :name, presence: true, length: { maximum: 40 }
  validate :acceptable_avatar

  private

  def acceptable_avatar
    return unless avatar.attached?

    unless avatar.blob.byte_size <= 1.megabyte
      errors.add(:avatar, :too_big)
    end

    acceptable_types = ['image/png', 'image/jpeg', 'image/jpg']
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, :wrong_type)
    end
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update(user_id: self.id)
  end
end
