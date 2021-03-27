# frozen_string_literal: true

require 'faker'


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cart.destroy_all
# Favorite.destroy_all
# SaleDrink.destroy_all
# Review.destroy_all

Sale.destroy_all
Drink.destroy_all

Category.destroy_all
Brand.destroy_all
Style.destroy_all
User.destroy_all

puts 'Insert user'
user = User.create(name: 'Test User', email: 'test@mail.com', password: '123456', direction: 'Pl. Saturno Luna 2', birth_date: '20-07-1998')
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

puts 'start drink insertion'
presentacion = ['Bottle 1.1 L.', 'Bottle 650 ml.', 'Bottle 330 ml.', 'Lata 335 ml.']
brands = Brand.all
styles = Style.all
categories = Category.all

30.times do
  Drink.create(
    name: Faker::Beer.name,
    presentation: presentacion.sample,
    description: 'New drink',
  price: rand(49) + 1,
  stock: 12 + rand(60),
  alcohol_grades: Faker::Beer.alcohol.to_f,
  brand: brands.sample,
  style: styles.sample,
  category: categories.sample
  )
end
puts 'End drink insertion'

puts 'start insertion of carts'
drinks = Drink.all
5.times do
  Cart.create(
  quantity: rand(10) + 1,
  drink: drinks.sample,
  user: user
  )
end
puts 'End insertion of carts'


puts 'start insertion of sales'
3.times do |ite|
  Sale.create(
  total: (1 * rand(9)) * 5,
  user: user,
  code: "SALE-000#{ite}"
  )
end
puts 'End insertion of sales'

puts 'start insertion of reviews'
drinks = Drink.all
10.times do
  Review.create(
  drink: drinks.sample,
  rating: rand(0...6),
  comment: Faker::Quote.famous_last_words,
  user: user
  )
end
puts 'End insertion of reviews'

puts 'start insertion of favorites'
drinks = Drink.all
10.times do
  Favorite.create(
  drink: drinks.sample,
  user: user
  )
end
puts 'End insertion of favorites'

