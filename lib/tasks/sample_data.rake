namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Brad Eaton",
                 email: "brad@eaton-family.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    puts "Added admin user: #{admin.name}, #{admin.email}, #{admin.password}"
    print "Adding test users"
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      print "."
    end
    puts ""
  end
end