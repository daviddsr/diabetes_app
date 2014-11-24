# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Control.create(level: 112, period: Control.periods[0], day: (Date.today() -2.days))

Control.create(level: 144, period: Control.periods[3], day: 2.days.ago)

Control.create(level: 122, period: Control.periods[2], day: 2.days.ago)

Control.create(level: 133, period: Control.periods[1], day: 3.days.ago)

Ingredient.create(name: 'Potatoes', ratio: 50)

Ingredient.create(name: 'Rice', ratio: 15)

Ingredient.create(name: 'Banana', ratio: 50)



