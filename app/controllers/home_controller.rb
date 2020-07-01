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

  def IRC
  end

  def forum
  end

  def raise_exception
    raise "This is a test for exception notification"
  end

  def public_profile
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def signup_confirm
  end
end
