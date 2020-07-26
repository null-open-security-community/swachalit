class EventSessionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  load_and_authorize_resource :only => [:edit, :update]

  def index
    @page = (params[:page] || 1).to_i
    @per_page = 50

    @event_sessions = EventSession.
      where(:placeholder => false).
      where('event_sessions.end_time < ?', Time.now)

    @event_sessions = @event_sessions.
      where('event_sessions.name LIKE ?', '%' + @query + '%') unless (@query = params[:q]).blank?

    @event_sessions = @event_sessions.
      order('event_sessions.start_time DESC').
      includes(:event).includes(:user)

    @event_sessions = @event_sessions.page(@page).per(@per_page)

    respond_to do |format|
      format.html
    end
  end

  def show
    @event_session = EventSession.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    # Resource loaded and authorized by CanCan

    respond_to do |format|
      format.html
    end
  end

  def update
    # Resource loaded and authorized by CanCan

    # Allow only description update
    evs_params = params[:event_session].symbolize_keys()
    evs_params.delete_if {|e|
      ![
        :name,
        :description,
        :presentation_url,
        :video_url
      ].include?(e)
    }

    respond_to do |format|
      if @event_session.update_attributes(evs_params)
        format.html do
          redirect_to event_session_path(@event_session)
        end
      else
        format.html do
          render :action => 'edit'
        end
      end
    end
  end

  def my_sessions
    @event_sessions = current_user.speaker_sessions

    respond_to do |format|
      format.html
    end
  end
end
