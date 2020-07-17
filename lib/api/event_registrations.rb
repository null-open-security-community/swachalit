require_relative 'helper'
require_relative 'entities/event_registration_entity'

module API
  class EventRegistration < Grape::API
    include ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :event_registrations do
      desc 'Returns list of registrations belonging to the event allowed by user' do
        success EventRegistrationEntity
      end
      params do
        optional :page, type: Integer, desc: 'Page number for pagination'
        optional :per_page, type: Integer, desc: 'Per page count for pagination'
      end
      get do
        page = (params[:page] || 0).to_i
        per_page = [params[:per_page].to_i, 100].max

        present Event.public_events.find(params[:event_id])\
          &.visible_registrations.page(page).per(per_page), with: EventRegistrationEntity
      end
    end

  end
end
