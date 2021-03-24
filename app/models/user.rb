# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_one_attached :profile
  enum role: { member: 0, admin: 1 }

  validates :name, presence: true, length: { minimum: 2, maximum: 60 }
  validates :email, presence: true, email: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, maximum: 120 }
  validates :direction, length: { minimum: 3 }, allow_blank: true
end
