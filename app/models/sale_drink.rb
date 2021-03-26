class SaleDrink < ApplicationRecord
  belongs_to :sale
  belongs_to :drink

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :drink_id, uniqueness: { scope: :sale_id }
end
