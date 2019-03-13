event_id = ARGV.shift.to_i
addrs = File.readlines(ARGV.shift.to_s).map {|e| e = e.to_s.strip; e unless e.empty? }.compact()

event = Event.find(event_id)
addrs.each do |ea|
  u = User.where(:email => ea).first()
  if u.nil?
    puts "User: #{ea} is not registered"
    next
  end

  er = EventRegistration.where(:event_id => event.id, :user_id => u.id).first()
  unless er.nil?
    puts "User: #{ea} is already registered for event"
    next
  end

  puts "Creating confnirmed registration for: #{ea}"
  EventRegistration.new do |event_registration|
    event_registration.event_id = event.id
    event_registration.user_id = u.id
    event_registration.state = ::EventRegistration::STATE_CONFIRMED
    event_registration.visible = false
    event_registration.save!
  end
end
