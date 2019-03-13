class Leads::EventSessionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_leader!
  before_filter :load_authorize_event!

  ##
  # If we are authorizing the event and scoping everything inside event,
  # then we need not authorize actions on event sessions. ????
  ##

  def index
    @event_sessions = @event.event_sessions

    respond_to do |format|
      format.html
    end
  end

  def show
    @event_session = @event.event_sessions.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @event_session = @event.event_sessions.new
    @event_session.start_time = Time.now
    @event_session.end_time = Time.now + 1.hour

    respond_to do |format|
      format.html
    end
  end

  def create
    @event_session = @event.event_sessions.new(params[:event_session])
    @event_session.event_id = @event.id   # Override mass-assignment attempt
 
    respond_to do |format|
      format.html do
        if @event_session.save
          redirect_to leads_event_event_session_path(@event, @event_session), :notice => "Event session created successfully."
        else
          render :action => 'new'
        end
      end
    end
  end

  def edit
    @event_session = @event.event_sessions.find(params[:id])
    
    respond_to do |format|
      format.html
    end  
  end

  def update
    @event_session = @event.event_sessions.find(params[:id])

    updated_attributes = params[:event_session]
    updated_attributes.delete(:event_id)

    respond_to do |format|
      format.html do
        if @event_session.update_attributes(updated_attributes)
          redirect_to leads_event_event_session_path(@event, @event_session), :notice => "Event session has been updated successfully."
        else
          render :action => 'edit'
        end
      end
    end
  end

  def destroy
    @event_session = @event.event_sessions.find(params[:id])
    #@event_session.destroy()

    redirect_to leads_event_event_sessions_path(@event), :alert => "Session deletion disabled currently."
  end

  def suggest_user
    @users = User.where("name LIKE ? OR email LIKE ?", 
      "%" + params[:q].to_s + "%",
      "%" + params[:q].to_s + "%")
    @users = @users.limit(5)

    render :json => @users.map {|u| { :id => u.id, :name => u.name, :email => u.email} }
  end

  private

  def load_authorize_event!
    @event = ::Event.find(params[:event_id].to_i)
    authorize! :manage, @event
  end

end
