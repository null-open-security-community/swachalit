class EventsController < ApplicationController

  def seo_name
    @event = Event.find_by!(slug: params[:name])

    respond_to do |format|
      format.html { render :action => 'show' }
    end
  end

  def index
    redirect_to upcoming_path
  end

  def show
    @event = Event.find(params[:id].to_i)

    respond_to do |format|
      format.html
      format.json { render :json => @event }
    end
  end

end
