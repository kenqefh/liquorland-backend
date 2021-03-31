# frozen_string_literal: true

class Style < ApplicationRecord
  validates :name, presence: true

  has_many :drinks, dependent: :destroy
end
