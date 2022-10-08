# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, birthday: Faker::Date.birthday(min_age: 18, max_age: 65), country_of_origin: Faker::Address.country, level: Faker::Number.within(range: 1..2), points: 0, tier: "Standard", birthday_reward: false, total_amount_spent: 0, total_amount_spent_foreign: 0, unused_amount: 0, unused_amount_foreign: 0)
end

50.times do |i|
  Purchase.create(user_id: Faker::Number.between(from: 1, to: 10), date: Faker::Date.between(from: '2020-01-01', to: Date.today), amount: Faker::Number.between(from: 1, to: 400), country_of_purchase: Faker::Address.country, counted: false, processed_for_points: false)
end
