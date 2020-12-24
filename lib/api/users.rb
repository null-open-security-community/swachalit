require_relative 'helper'
require_relative 'entities/event_entity'
require_relative 'entities/event_session_entity'

module API
  class Users < Grape::API

    helpers ::API::Helper

    version 'v1', using: :header, vendor: 'swachalit'
    format :json

    resource :users do
      before do
        authenticate_api_user!
      end

      desc 'Return logged in user info'
      get 'me' do
        # TODO: Use Grape entity
        h = {}

        [
          :id, :email,
          :name, :homepage, :about_me, :twitter_handle, :facebook_profile,
          :github_profile, :linkedin_profile, :handle, :avatar,
          :updated_at, :created_at
        ].each do |k|
          h[k] = current_user.send(k)
        end

        h
      end

      desc "Return list of user's registered events" do
        success EventEntity
      end
      get 'events' do
        present current_user.registered_participation.map(&:event), \
          with: EventEntity
      end

      desc "Return list of user's delivered sessions" do
        success EventSessionEntity
      end
      get 'sessions' do
        present current_user.speaker_sessions, \
          with: EventSessionEntity
      end
    end

  end
end
