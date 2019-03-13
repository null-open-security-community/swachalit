require 'securerandom'

$admin_user_email = 'admin@null.co.in'
$admin_user_pass  = 'devTest1'

$user_email = 'dev@null.co.in'
$user_pass  = 'devTest1'

def get_random_string()
  SecureRandom.hex
end

# Create chapters
10.times do
  Chapter.create({
    :name => get_random_string(),
    :description => 'Developer seed chapter',
    :birthday => Time.now,
    :code => get_random_string(),
    :active => true,
    :country => 'India',
    :city => 'ABC',
    :state => 'XYZ',
    :chapter_email => 'devtest@null.co.in'
  })
end

# Create venues
10.times do
  Chapter.all.each do |chapter|
    Venue.create({
      :chapter_id => chapter.id,
      :name => get_random_string(),
      :description => 'Developer seed venue',
      :address => 'Venue address',
      :contact_name => 'Dev Seed',
    })
  end
end

EventType.create([
  { :name => 'Meet', :description => 'Regular Meet', :public => true, :registration_required => true, :invitation_required => false },
  { :name => 'Humla', :description => 'null Humla', :public => false, :registration_required => true, :invitation_required => true },
  { :name => 'Puliya', :description => 'null Puliya', :public => false, :registration_required => true, :invitation_required => true }
])

10.times do 
  Chapter.all.each do |chapter|
    Event.create({
      :event_type_id => EventType.all.sample.id,

    })
  end
end
