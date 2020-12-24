class EventRegistrationsController < ApplicationController
  before_filter :token_authenticate_user!
  before_filter :authenticate_user!, :except => [:index]
  before_filter :load_event!

  def index
    @event_registrations = @event.visible_registrations.includes(:user)

    respond_to do |format|
      format.html
    end
  end

  def new
    @event_registration = @event.event_registrations.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @event_registration = @event.event_registrations.new(params[:event_registration])
    @event_registration.event = @event
    @event_registration.user = current_user

    c_ret = true
    c_ret = verify_recaptcha(model: @event_registration) unless is_api_user?

    respond_to do |format|
      if c_ret and @event_registration.save
        format.html do
          redirect_to event_path(@event), :notice => 'You have successfully registered with the event.'
        end

        format.json do
          render :json => @event_registration
        end

      else
        format.html do
          render :action => 'new'
        end

        format.json do
          render :status => :unprocessable_entity, :json => @event_registration.errors
        end

      end
    end
  end

  def destroy
    @event_registration = @event.event_registrations.find(params[:id])
    @event_registration.destroy() if current_user.id == @event_registration.user_id

    respond_to do |format|
      format.html do
        redirect_to event_path(@event), :notice => 'You have successfully unregistered with the event.'
      end

      format.json do
        render :json => @event_registration
      end
    end
  end

  private

  def load_event!
    @event = Event.find(params[:event_id])
  end
end
