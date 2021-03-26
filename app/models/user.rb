# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_one_attached :profile
  has_many :sales
  has_many :reviews
  has_many :carts
  has_many :favorites
  has_many :drinks_cart, through: :carts, source: :drink
  has_many :drinks_favorite, through: :favorites, source: :drink
  

  validates :name, presence: true, length: { minimum: 2, maximum: 60 }
  validates :email, presence: true, email: true, uniqueness: true
  validates :direction, length: { minimum: 3 }, allow_blank: true

  enum role: { member: 0, admin: 1 }

  def invalidate_token
    update(token: nil)
  end
end
