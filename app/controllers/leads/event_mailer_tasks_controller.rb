class Leads::EventMailerTasksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_leader!
  before_filter :load_authorize_event!

  def index
    @event_mailer_tasks = ::EventMailerTask.where(:event_id => @event.id)

    respond_to do |format|
      format.html
    end
  end

  def show
    @event_mailer_task = ::EventMailerTask.where(:event_id => @event.id).find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @event_mailer_task = ::EventMailerTask.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @event_mailer_task = ::EventMailerTask.new(params[:event_mailer_task])
    @event_mailer_task.event = @event

    respond_to do |format|
      format.html do
        if @event_mailer_task.save
          redirect_to leads_event_event_mailer_task_path(@event, @event_mailer_task), :notice => "Event Mailer Task created successfully."   
        else
          render :action => 'new'
        end
      end
    end
  end

  def edit
    @event_mailer_task = ::EventMailerTask.where(:event_id => @event.id).find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @event_mailer_task = ::EventMailerTask.where(:event_id => @event.id).find(params[:id])

    updated_attributes = params[:event_mailer_task]
    updated_attributes.delete(:event_id)
    updated_attributes.delete(:executed)

    # This is required to prevent accidental deliver/re-delivery of mails
    updated_attributes[:ready_for_delivery] = false

    respond_to do |format|
      format.html do
        if @event_mailer_task.update_attributes(updated_attributes)
          redirect_to leads_event_event_mailer_task_path(@event, @event_mailer_task), :notice => "Event Mailer Task updated successfully."   
        else
          render :action => 'edit'
        end
      end
    end
  end

  def execute
    @event_mailer_task = ::EventMailerTask.where(:event_id => @event.id).find(params[:id])

    if (params[:token] == form_authenticity_token) and (! @event_mailer_task.executed?) and (! @event_mailer_task.ready_for_delivery?)
      @event_mailer_task.executed = false
      @event_mailer_task.ready_for_delivery = true
      @event_mailer_task.save()
    end

    respond_to do |format|
      format.html do
        redirect_to leads_event_event_mailer_tasks_path(@event)
      end
    end
  end

  private

  def load_authorize_event!
    @event = ::Event.find(params[:event_id].to_i)
    authorize! :manage, @event
  end
end