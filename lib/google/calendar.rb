module GoogleAPI
  
  class CalendarEvent
    attr_accessor :summary
    attr_accessor :description
    attr_accessor :location
    attr_accessor :start    # DateTime
    attr_accessor :end      # DateTime

    def serialize
      {
        :summary => self.summary.to_s,
        :description => self.description.to_s,
        :location => self.location.to_s,
        :start => { :dateTime => self.start.rfc3339 },
        :end => { :dateTime => self.end.rfc3339 }
      }
    end

    def self.load(str)
      # TODO
    end
  end

  class CalendarV3
    SCOPE_URL = "https://www.googleapis.com/auth/calendar"

    def initialize(client, calendar_id)
      @client = client
      @calendar_id = calendar_id
      @calendar_service = @client.discovered_api('calendar', 'v3')
    end

    def insert_event(event)
      response = @client.execute(:api_method => @calendar_service.events.insert,
        :parameters => { :calendarId => @calendar_id }, 
        :body_object => event.serialize(),
        :headers => {'Content-Type' => 'application/json'})

      return response.data
    end

    def update_event(event_id, event)
      response = @client.execute(:api_method => @calendar_service.events.update,
        :parameters => { :calendarId => @calendar_id, :eventId => event_id }, 
        :body_object => event.serialize(),
        :headers => {'Content-Type' => 'application/json'})

      return response.data
    end

    def delete_event(event_id)
      @client.execute(:api_method => @calendar_service.events.delete,
        :parameters => { :calendarId => @calendar_id, :eventId => event_id })

      return nil
    end
  end

end