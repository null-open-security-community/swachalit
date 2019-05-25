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
  
  %w(Meet Humla Puliya).each do |type|
    EventType.create(name: type, max_participant: 10, public: true, registration_required: false, invitation_required: false)
  end

  10.times do |i|
    Chapter.create(name: "Chapter-#{i}", description: "Chapter-#{i}", code: "chapter-#{i}")
  end

  10.times do |i|
    Venue.create(name: "Venue-#{i}", chapter_id: i+1, address: "Venue-#{i} Address", contact_name: "Contact-#{i}")
  end

  10.times do |i|
    Event.create({
      venue_id: i+1,
      chapter_id: i+1,
      event_type_id: 1+rand(3),
      name: "Event Test-#{i}",
      start_time: Time.now + i.days,
      end_time: Time.now + i.days + 1.year
      registration_start_time: Time.now
      registration_end_time: Time.now + i.days + 1.year
    })
  end

  10.times do |i|
    EventSession.create({
      event_id: i+1,
      user_id: 1,
      name: "Event Session #{i}",
      description: "Event Description #{i}",
      placeholder: false,
      start_time: Time.now + i.days + 1.hour,
      end_time: Time.now + i.days + 2.hour
    })
  end
end