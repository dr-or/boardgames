class Photo < ApplicationRecord
  belongs_to :game
  belongs_to :user

  scope :persisted, -> { where "id is NOT NULL" }

  validates :photo, presence: true
end
