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
Favorite.destroy_all
SaleDrink.destroy_all
Review.destroy_all

Sale.destroy_all
Drink.destroy_all

Category.destroy_all
Brand.destroy_all
Style.destroy_all
User.destroy_all


def get_image(folder, file_name)
  { io: File.open(File.join(Rails.root, "/app/assets/images/#{folder}/#{file_name}")), filename: file_name }
end

puts 'Insert user'
user = User.create(name: 'Test User', email: 'test@mail.com', password: '123456', direction: 'Pl. Saturno Luna 100', birth_date: '2000-01-01')
user.avatar.attach(get_image('profiles', 'photo_0.jpg'))

user1 = User.create(name: 'Diana', email: 'diana@mail.com', password: '123456', direction: 'Pl. Saturno Luna 0', birth_date: '2000-12-01')
user1.avatar.attach(get_image('profiles', 'photo_0.jpg'))

user2 = User.create(name: 'Dina', email: 'dina@mail.com', password: '123456', direction: 'Pl. Saturno Luna 2', birth_date: '1998-07-20')
user2.avatar.attach(get_image('profiles', 'photo_1.jpg'))

user3 = User.create(name: 'Frank', email: 'frank@mail.com', password: '123456', direction: 'Pl. Saturno Luna 4', birth_date: '1990-01-01')
user3.avatar.attach(get_image('profiles', 'photo_2.jpg'))
puts 'END Insert user'

puts 'Insert brands'
10.times do
  Brand.create(name: Faker::Beer.brand)
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
    color: category_data[:color],
    cover: get_image('categories', category_data[:image])
  }
  Category.create(category)
end
puts 'end insertion of categories'

puts 'start drink insertion'
presentations = ['Bottle 1.1 L.', 'Bottle 650 ml.', 'Bottle 330 ml.', 'Lata 335 ml.']
brands = Brand.all
styles = Style.all
categories = Category.all
users = [user, user1, user2, user3]

30.times do
  Drink.create(
    name: Faker::Beer.name,
    presentation: presentations.sample,
    description: 'New drink',
    price: rand(49) + 1,
    stock: 12 + rand(60),
    alcohol_grades: Faker::Beer.alcohol.to_f,
    brand: brands.sample,
    style: styles.sample,
    category: categories.sample,
    image: get_image('beers', '0.jpg')
  )
end
puts 'End drink insertion'

puts 'start insertion of carts'
drinks = Drink.all
6.times do
  Cart.create(
  quantity: rand(10) + 1,
  drink: drinks.sample,
  user: users.sample
  )
end
puts 'End insertion of carts'


puts 'start insertion of sales'
15.times do |ite|
  code = "SALE-000#{ite + 1}"
  total = 0
  user = users.sample
  sale = Sale.new(user: user, total: 0, code: code)

  drinks.sample(rand(8)).each do |drink|
    quantity = 1 + rand(5)
    sale_drink = SaleDrink.new(drink: drink, quantity: quantity)
    sale.sale_drinks.push(sale_drink)

    total += drink.price * quantity
  end

  sale.total = total
  sale.save
end
puts 'End insertion of sales'

puts 'start insertion of reviews'
drinks = Drink.all
40.times do
  Review.create(
    drink: drinks.sample,
    rating: rand(3...6),
    comment: Faker::Quote.famous_last_words,
    user: users.sample
  )
end
puts 'End insertion of reviews'

puts 'start insertion of favorites'
25.times do
  Favorite.create(
    drink: drinks.sample,
    user: users.sample
  )
end
puts 'End insertion of favorites'
