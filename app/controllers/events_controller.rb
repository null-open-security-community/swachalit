class EventsController < ApplicationController
  
  def seo_name
    @event = Event.where(:slug => params[:name]).first()

    respond_to do |format|
      format.html { render :action => 'show' }
    end
  end

  def show
    @event = Event.find(params[:id].to_i)

    respond_to do |format|
      format.html
      format.json { render :json => @event }
    end
  end

end
