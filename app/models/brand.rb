# frozen_string_literal: true

class Brand < ApplicationRecord
  validates :name, presence: true

  has_many :drinks, dependent: :destroy
end
