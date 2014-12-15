# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Ingredient.create(name: 'Potatoes', ratio: 50)

Ingredient.create(name: 'Rice', ratio: 15)

Ingredient.create(name: 'Banana', ratio: 50)

user = User.create!(
        name: "Paco",
        email: "meloinvento@invento.com",
      password: "123456789",
      password_confirmation: "123456789"
      )

Control.create(level: 100, period: "pre-breakfast", day: DateTime.now, user_id: user.id)


