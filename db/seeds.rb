# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env.production?
  # This is required so that we don't need Redis during seeding
  Resque.inline = true

  Rails.application.config.action_mailer.perform_deliveries = false
  Rails.application.config.action_mailer.raise_delivery_errors = false

  ActionMailer::Base.perform_deliveries = false

  # Disable background tasks
  ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"] = "true"

  # Create the dummy data
  AdminUser.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
  
  User.create(:name => 'Developer User', :email => 'developer@localhost.local', 
    :password => 'password',:password_confirmation => 'password')

  User.where(email: 'developer@localhost.local').first.confirm()

  User.create(name: 'Test User', email: 'testuser@localhost.local',
    password: 'password', password_confirmation: 'password')

  User.where(email: 'testuser@localhost.local').first.confirm()
  
  %w(Meet Humla Puliya).each do |type|
    EventType.create(name: type, max_participant: 10, public: true, registration_required: false, invitation_required: false)
  end

  10.times do |i|
    Chapter.create(name: "Chapter-#{i}", description: "Chapter-#{i}", code: "chapter-#{i}")
  end

  10.times do |i|
    ChapterLead.create({
      user_id: 1,
      chapter_id: i+1,
      active: true
    })
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
      public: true,
      can_show_on_homepage: true,
      can_show_on_archive: true,
      accepting_registration: true,
      max_registration: 100,
      start_time: Time.now + 1.hour + i.days,
      end_time: Time.now + i.days + 1.year,
      registration_start_time: Time.now,
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
      start_time: Time.now + i.days + 2.hour,
      end_time: Time.now + i.days + 4.hour
    })
  end

  5.times do |i|
    Page.create({
      name: "Page #{i}",
      description: "Page #{i}",
      navigation_name: "page-#{i}",
      title: "Page Title #{i}",
      content: "Page Content #{i}",
      published: true
    })
  end
end
