class Category < ApplicationRecord
  validates :name, presence: { message: "can't be blank. Please write something!" }
  validates :description, presence: true, length: { maximum: 150 }

  has_one_attached :cover, dependent: :destroy
  has_many :drinks, dependent: :destroy

  def cover_url
    if cover.attached?
      Rails.application.routes.default_url_options[:host] = 'https://liquorland-backend.herokuapp.com'
      # Rails.application.routes.default_url_options[:host] = 'http://localhost:3000'
      Rails.application.routes.url_helpers.url_for(cover)
    end
  end
end
