class ChaptersController < ApplicationController

  def index
    @chapters = Chapter.order(:name)
    @chapter_address = @chapters.map do |chapter|
      if (a = chapter.locations) and a.first
        { 'cordinates' => a.first.coordinates, 'active' => chapter.active, 'name' => chapter.name }
      else
        nil
      end
    end.compact

    respond_to do |format|
      format.html
    end
  end

  def show
    @chapter = Chapter.find(params[:id])

    flash.alert = 'This chapter is not active currently' unless @chapter.active?

    respond_to do |format|
      format.html
    end
  end

  def leaders
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      format.json do
        render :json => @chapter.leads.map {|u| {id: u.id, name: u.name } }
      end
    end
  end

  def upcoming_events
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      format.json do
        render :json => @chapter.upcoming_events
      end
    end
  end

  def calendar
    @chapter = Chapter.find(params[:id])
    send_data @chapter.upcoming_events_ics, :type => 'text/calendar', :disposition => 'inline', :filename => 'calendar.ics'
  end

end
