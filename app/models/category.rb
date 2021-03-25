class Category < ApplicationRecord
  validates :name, presence: { message: "can't be blank. Please write something!" }
  validates :description, presence: true, length: { maximum: 150 }

  has_one_attached :cover
end
