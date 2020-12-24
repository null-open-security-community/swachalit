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

    @event_sessions = @event_sessions.has_a_reference if \
      (@has_a_reference = params[:has_a_reference].to_i).positive?

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

  def like
    @event_session = EventSession.find_for_voting(params[:id])

    if current_user.voted_up_on? @event_session
      @event_session.unliked_by current_user
    else
      current_user.likes @event_session
    end

    respond_to do |format|
      format.html { redirect_to event_session_path(@event_session) }
      format.js { render 'vote' }
    end
  end

  def dislike
    @event_session = EventSession.find_for_voting(params[:id])

    if current_user.voted_down_on? @event_session
      @event_session.undisliked_by current_user
    else
      current_user.dislikes @event_session
    end

    respond_to do |format|
      format.html { redirect_to event_session_path(@event_session) }
      format.js { render 'vote' }
    end
  end
end
