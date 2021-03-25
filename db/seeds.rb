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
