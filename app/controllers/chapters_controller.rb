class ChaptersController < ApplicationController

  def show
    @chapter = Chapter.find(params[:id])

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
