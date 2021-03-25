class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :drink

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :user_id, uniqueness: { scope: :drink_id }
end
