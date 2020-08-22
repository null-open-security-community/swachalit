class HomeController < ApplicationController
  def index
    @events = Event.future_public_events.order('start_time ASC')

    respond_to do |format|
      format.html
    end
  end

  def upcoming
    @events = Event.future_public_events.order('start_time ASC')

    respond_to do |format|
      format.html
      format.json { render :json => @events.map {|event| event.to_brief_json} }
    end
  end

  def archives
    @page = (params[:page] || 1).to_i
    @per_page = 50

    @events = Event.archives.order('start_time DESC')
    @events = @events.where(:chapter_id => params[:chapter_id].to_i) if params[:chapter_id]
    @events = @events.page(@page).per(@per_page)

    respond_to do |format|
      format.html
    end
  end

  def about
  end

  def calendar
  end


  def raise_exception
    raise "This is a test for exception notification"
  end

  def public_profile
    @user = User.find(params[:id])
    @event_participation = []

    @user.speaker_sessions.each do |sess|
      @event_participation << { type: 'speaker', event: sess.event }
    end

    @user.registered_participation.each do |event_registration|
      @event_participation << { type: 'attendee', event: event_registration.event }
    end

    @event_participation = @event_participation.sort_by do |x|
      x[:event].start_time
    end.reverse

    respond_to do |format|
      format.html
    end
  end

  def signup_confirm
  end

  def privacy
  end
end
