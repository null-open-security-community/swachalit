require_relative 'chapter_entity'

module API
  class EventEntity < Grape::Entity
    expose :id, documentation: { type: Integer, desc: 'Event ID' }
    expose :event_type, documentation: { type: String, desc: 'The type of the event' } do |m|
      m.event_type.name
    end
    expose :chapter, with: API::ChapterEntity
    expose :name, documentation: { type: String, desc: 'Event name' }
    expose :description, documentation: { type: String, desc: 'Event description (Markdown)' }
    expose :start_time
    expose :end_time
  end
end
