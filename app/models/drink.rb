class Drink < ApplicationRecord
  belongs_to :brand
  belongs_to :style
  belongs_to :category
  has_many :carts
  has_many :users_cart, through: :carts, source: :user
  has_one_attached :image

  validates :name, presence: true, length: { minimum: 2, maximum: 60 }
  validates :presentation, presence: true, length: { minimum: 2, maximum: 40 }
  validates :description, length: { minimum: 2, maximum: 300 }, allow_blank: true
  validates :price, :stock, :alcohol_grades, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
