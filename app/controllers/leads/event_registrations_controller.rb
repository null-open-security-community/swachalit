class Leads::EventRegistrationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_leader!
  before_filter :load_authorize_event!

  def index
    @event_registrations = @event.event_registrations.order('created_at DESC')

    respond_to do |format|
      format.html
    end
  end

  def mass_update
    @event_registrations = @event.event_registrations

    errors = []
    if params[:token] == form_authenticity_token
      params[:event_registrations].each do |event_registration|
        begin
          @event_registrations.find(event_registration[:id]).set_state!(event_registration[:state])
        rescue => e
          errors << {
            registration_id: event_registration[:id],
            error_message: e.message
          }
        end
      end
    end

    respond_to do |format|
      if errors.any?
        format.json { render :json => {'status' => 'OK'} }
      else
        # Some or all have raised error
        format.json { render :json => {'status' => 'FAILED', 'errors' => errors } }
      end
    end
  end

  private

  def load_authorize_event!
    @event = ::Event.find(params[:event_id].to_i)
    authorize! :manage, @event
  end
end
