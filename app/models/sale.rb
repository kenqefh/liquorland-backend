# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :user
  has_many :sale_drinks
  has_many :drinks, through: :sale_drinks, source: :drink

  validates :total, numericality: { greater_than_or_equal_to: 0 }
end
