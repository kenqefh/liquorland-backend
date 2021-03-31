# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_one_attached :avatar, dependent: :destroy
  has_many :sales
  has_many :reviews
  has_many :carts
  has_many :favorites
  has_many :drinks_cart, through: :carts, source: :drink
  has_many :drinks_favorite, through: :favorites, source: :drink

  validates :name, presence: true, length: { minimum: 2, maximum: 60 }
  validates :email, presence: true, email: true, uniqueness: true
  validates :direction, length: { minimum: 3 }, allow_blank: true

  validates :birth_date, presence: true
  validate :under_age

  enum role: { member: 0, admin: 1 }

  def invalidate_token
    update(token: nil)
  end


  def avatar_url
    if avatar.attached?
      Rails.application.routes.default_url_options[:host] = 'https://liquorland-backend.herokuapp.com'
      # Rails.application.routes.default_url_options[:host] = 'http://localhost:3000'
      Rails.application.routes.url_helpers.url_for(avatar)
    end
  end

  private
    def under_age
      return if !birth_date.nil? && birth_date <= 18.years.ago

      errors.add(:birth_date, 'You should be 18 years old to create and account')
    end
end
