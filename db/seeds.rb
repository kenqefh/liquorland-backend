# frozen_string_literal: true

require 'faker'


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Insert user'
User.create(name: 'Test User', email: 'test@mail.com', password: '123456', direction: 'Pl. Saturno Luna 2')
puts 'END Insert user'

puts 'Insert brands'
10.times do
  brand_data = {
    name: Faker::Beer.brand
  }
  Brand.create(brand_data)
end
puts 'end insertion of brands'

puts 'Insert styles'
10.times do
  style_data = {
    name: Faker::Beer.style
  }
  Style.create(style_data)
end
puts 'end insertion of styles'

puts 'Insert categories'
Category.destroy_all
categories_data = JSON.parse(File.read('db/categories.json'), symbolize_names: true)
categories_data.each do |category_data|
  category = {
    name: category_data[:name],
    description: category_data[:description],
    color: category_data[:color]
  }
  new_category = Category.create(category)
end
puts 'end insertion of categories'