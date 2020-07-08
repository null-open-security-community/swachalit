require_relative 'user_entity'

module API
  class EventRegistrationEntity < Grape::Entity
    expose :id, documentation: { type: Integer, desc: 'Event Registration ID' }
    expose :event_id, documentation: { type: Integer, desc: 'The event this registration belongs to' }
    expose :user, using: ::API::UserEntity
  end
end
