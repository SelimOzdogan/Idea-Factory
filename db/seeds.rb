# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Review.destroy_all
Idea.destroy_all

password = 1
User.create({
  name: "Selim Ozdogan",
  email: "selimozdogan@hotmail.com",
  password: password.to_s,
})
4.times do
  password += 1
  User.create({
    name: Faker::Name.first_name + " " + Faker::Name.last_name,
    email: Faker::Internet.email,
    password: password.to_s,
  })
end

users = User.all

10.times do
  i = Idea.create({
    title: Faker::Lorem.question,
    description: Faker::Hacker.say_something_smart,
    user: users.sample,
  })
  if i.valid?
    rand(0..5).times.each do
      Review.create(
        body: Faker::Hacker.say_something_smart,
        idea: i,
        user: users.sample,
      )
    end
  end
end
puts "Created #{Idea.count} Ideas"
puts "Created #{Review.count} Reviews"
puts "Created #{User.count} Users"
