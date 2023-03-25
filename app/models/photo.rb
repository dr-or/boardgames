class Photo < ApplicationRecord
  belongs_to :game
  belongs_to :user

  scope :persisted, -> { where "id is NOT NULL" }

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_fit: [100, 100]
  end

  validates :photo,
            attached: true,
            content_type: ['image/png', 'image/jpeg', 'image/jpg'],
            size: { less_than: 1.megabyte }
end
