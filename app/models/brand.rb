# frozen_string_literal: true

class Brand < ApplicationRecord
  validates :name, presence: true
end
