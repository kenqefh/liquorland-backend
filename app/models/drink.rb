class Drink < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :brand
  belongs_to :style
  belongs_to :category
  has_many :carts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users_cart, through: :carts, source: :user, dependent: :destroy
  has_many :sale_drinks, dependent: :destroy
  has_many :sales, through: :sale_drinks, source: :sale, dependent: :destroy
  has_many :users_favorite, through: :favorites, source: :user, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  has_many :reviews, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 60 }
  validates :presentation, presence: true, length: { minimum: 2, maximum: 40 }
  validates :description, length: { minimum: 2, maximum: 300 }, allow_blank: true
  validates :price, :stock, :alcohol_grades, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def rating_avg
    return 0.0 if reviews_count === 0
    (reviews.map { |i| i.rating }.sum.to_f / reviews_count).round(1)
  end

  def image_url
    if image.attached?
      Rails.application.routes.default_url_options[:host] = 'https://liquorland-backend.herokuapp.com'
      # Rails.application.routes.default_url_options[:host] = 'http://localhost:3000'
      Rails.application.routes.url_helpers.url_for(image)
    end
  end
end
