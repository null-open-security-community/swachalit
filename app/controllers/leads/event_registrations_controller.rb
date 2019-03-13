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

    if params[:token] == form_authenticity_token
      params[:event_registrations].each do |event_registration|
        @event_registrations.find(event_registration[:id]).set_state!(event_registration[:state]) rescue nil  # Lets avoid raising on invalid states
      end
    end

    respond_to do |format|
      format.json { render :json => {'status' => 'OK'} }
    end
  end

  private

  def load_authorize_event!
    @event = ::Event.find(params[:event_id].to_i)
    authorize! :manage, @event
  end
end
