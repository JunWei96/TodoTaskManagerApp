# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

User.create!(name:  "Jun Wei",
             email: "junwei@example.com",
             password:              "password",
             password_confirmation: "password",
             time_zone: "Singapore",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: "Jun Wei",
            email: "test@example.com",
            password: "password",
            password_confirmation: "password",
            time_zone: "Singapore",
            activated: true,
            activated_at: Time.zone.now)
