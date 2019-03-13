# This is an abstraction to generate statistics from various resources
class Stat
  
  attr_accessor :year
  attr_accessor :chapter

  def initialize(year = 2015)
    @year = year
    @chapter = nil
  end

  def events
    events = ::Event.where('start_time > ? AND start_time < ?', 
      Time.mktime(@year), Time.mktime(@year+1)).
      where(:public => true)
    events = events.where(:chapter_id => @chapter.id) unless @chapter.nil?

    return events
  end

  def event_sessions
    event_sessions = EventSession.where(:event_id => self.events.map {|e| e.id} ).
      where(:placeholder => false)

    return event_sessions
  end

  def event_registrations
    event_registrations = EventRegistration.where(:event_id => self.events.map {|e| e.id }).
      where(:state => EventRegistration::STATE_CONFIRMED)

    return event_registrations
  end

  def speakers
    self.event_sessions.map {|s| s.user }.uniq()
  end

  def top_speakers(n = 5)
    self.event_sessions.group(:user_id).order('count_user_id DESC').limit(n).count('user_id').map do |k, v|
      [User.find(k), v]
    end
  end

end
