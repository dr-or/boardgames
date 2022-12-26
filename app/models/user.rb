class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :email, presence: true, uniqueness: true,
    format: { with: /\A[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ }
end
