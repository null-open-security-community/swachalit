module API
  class EventSessionEntity < Grape::Entity
    expose :id, documentation: { type: Integer, desc: 'Event Session ID' }
    expose :name, documentation: { type: String, desc: 'Event Session name' }
    expose :description, documentation: { type: String, desc: 'Event Session description (Markdown)' }
    expose :session_type, documentation: { type: String, desc: 'Event Session type' }
    expose :tags, documentation: { type: String, desc: 'Event Session tags' }
    expose :presentation_url, documentation: { type: String, desc: 'Presentation URL' }
    expose :video_url, documentation: { type: String, desc: 'Video URL' }
    expose :start_time, documentation: { type: Time, desc: 'Start time' }
    expose :end_time, documentation: { type: Time, desc: 'End time' }
  end
end
