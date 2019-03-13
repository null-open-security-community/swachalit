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
        render :json => @chapter.leads.to_json(:only => [:id, :name])
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

end
