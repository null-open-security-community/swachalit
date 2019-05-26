class Leads::EventsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_leader!

  def index
    if params[:show_old]
      @events = current_user.managed_old_events()
    else
      @events = current_user.managed_events()
    end

    respond_to do |format|
      format.html
    end
  end

  def show
    @event = current_user.managed_events.find(params[:id].to_i) rescue 
      current_user.managed_old_events.find(params[:id].to_i)

    respond_to do |format|
      format.html
    end
  end

  def new
    @event = ::Event.new
    @event.start_time = Time.now
    @event.end_time = Time.now + 1.hour
    @event.registration_start_time = Time.now
    @event.registration_end_time = Time.now + 1.hour

    respond_to do |format|
      format.html
    end
  end

  def create
    @event = ::Event.new(params[:event])
    @event.public = false

    authorize! :create, @event

    respond_to do |format|
      format.html do
        if @event.save
          redirect_to leads_event_path(@event), :notice => "Event created successfully."
        else
          render :action => 'new'
        end
      end
    end
  end

  def edit
    @event = ::Event.find(params[:id])
    authorize! :edit, @event

    respond_to do |format|
      format.html
    end
  end

  def update
    @event = ::Event.find(params[:id])

    # This validation should go to model
    if @event.end_time < (Time.now)
      redirect_to leads_event_path(@event), :notice => 'Cannot edit the Event after End Date'
      return
    end
    
    updated_attributes = params[:event]
    #updated_attributes.delete(:public)

    @event.assign_attributes(updated_attributes)
    authorize! :edit, @event

    respond_to do |format|
      format.html do
        if @event.save
          redirect_to leads_event_path(@event), :notice => "Event updated successfully."
        else
          render :action => 'edit'
        end
      end
    end
  end

  def destroy
    @event = ::Event.find(params[:id])
    authorize! :delete, @event

    #@event.destroy()

    respond_to do |format|
      format.html do
        redirect_to :action => :index
      end
    end
  end

end
