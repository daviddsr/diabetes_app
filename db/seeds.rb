# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(
        name: "Paco",
        email: "meloinvento@invento.com",
      password: "123456789",
      password_confirmation: "123456789",
      confirmed_at: Time.now
      )

user = User.create!(
        name: "Repli",
        email: "repli@example.com",
      password: "12345678",
      password_confirmation: "12345678",
      confirmed_at: Time.now
      )

Control.create(level: 100, period: "pre-breakfast", day: DateTime.now, user_id: user.id)
