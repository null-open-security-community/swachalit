# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env.production?
  AdminUser.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
  
  User.create(:name => 'Developer User', :email => 'developer@localhost.local', 
    :password => 'password',:password_confirmation => 'password')
end