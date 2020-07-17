require_relative 'helper'
require_relative 'entities/event_session_entity'

module API
  class EventSession < Grape::API
    include ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :event_sessions do
      desc 'Returns list of sessions belonging to the event' do
        success EventSessionEntity
      end
      params do
        optional :page, type: Integer, desc: 'Page number for pagination'
        optional :per_page, type: Integer, desc: 'Per page count for pagination'
      end
      get do
        page = (params[:page] || 0).to_i
        per_page = [params[:per_page].to_i, 100].max

        present Event.public_events.find(params[:event_id])\
          &.event_sessions.page(page).per(per_page), with: EventSessionEntity
      end
    end

  end
end
