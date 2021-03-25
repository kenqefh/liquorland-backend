# frozen_string_literal: true

class Style < ApplicationRecord
  validates :name, presence: true
end
