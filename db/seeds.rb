# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "junwei",
             email: "junwei@example.com",
             password:              "ilovejingwen",
             password_confirmation: "ilovejingwen",
             time_zone: "Singapore",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "jingwen",
            email: "jingwen@example.com",
            password:              "ilovejunwei",
            password_confirmation: "ilovejunwei",
            time_zone: "Singapore",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               time_zone: "Singapore",
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  description = Faker::Lorem.sentence(5)
  due_date = Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today)
  users.each { |user| user.todo_posts.create!(description: description,
                                              due_date: due_date) }
end
