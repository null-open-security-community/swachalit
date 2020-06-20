class ChaptersController < ApplicationController

  def index
    all_chapters = Chapter.order(:name)
    @chapters = all_chapters.paginate(page: params[:page], per_page: 8)
    @chapter_address = []
    all_chapters.each do |chap|
      @chapter = chap
      def address
        if @chapter.city.present? && @chapter.state.present? && @chapter.country.present?
          @chapter.city+','+@chapter.state+','+@chapter.country
        elsif @chapter.city.present? && !@chapter.state.present? &&  @chapter.country.present?
          @chapter.city+','+@chapter.country
        end
      end
      if address.present? 
        results = Geocoder.search(address)
        begin
          @chapter_address << {'cordinates' => results.first.coordinates, 'active' => chap.active, 'name' => chap.name }
        rescue

        end
      end
    end
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
