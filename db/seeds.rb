

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# role
admin_role = Role.create(name: 'admin')

# user
admin = User.create(email: 'admin@email.com', password: 'admin', role: admin_role)
User.create(email: 'non-admin@email.com', password: 'admin')

# open Openings

5.times do |i|
  date = DateTime.now

  start_date = date.advance(days: 30)
  end_date = date.advance(months: 4)

  o = Opening.new(
      title: Faker::Lorem.unique.sentence,
      start_date: start_date,
      end_date: end_date,
      location: Faker::Address.unique.city,
      company: Faker::Company.unique.name,
      description: Faker::Lorem.unique.sentence,
      qualifications: Faker::Lorem.unique.paragraphs(2),
      user: admin
  )

  if i < 2
    o.start_date = date.advance(months: -1)
    o.end_date = date.advance(months: -4)
    o.save(validate: false)
  end

  o.save
end
