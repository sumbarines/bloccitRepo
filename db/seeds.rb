# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

5.times do
  user = User.new(
    name:   Faker::Name.name,
    email:  Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save
end
users = User.all

# Note: by calling `User.new` instead of `create`,
# we create an instance of User which isn't immediately saved to the database.

# The `skip_confirmation!` method sets the `confirmed_at` attribute
# to avoid triggering an confirmation email when the User is saved.

# The `save` method then saves this User to the database.

# Create Posts
50.times do
  Post.create(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end
posts = Post.all

#Create Comments
100.times do
  Comment.create(
    #user: users.sampe, # we have no yet associate users with comments
    post: posts.sample,
    body: Faker::Lorem.paragraph
    )
end

User.first.update_attributes(
  email: 'sumbev@gmail.com',
  password: 'helloworld',
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
