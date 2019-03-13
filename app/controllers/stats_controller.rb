class StatsController < ApplicationController
  
  def index
    redirect_to stat_path(:id => (Time.now.year - 1))
  end

  def show
    @year = (params[:id] || (Time.now.year - 1)).to_i
    @stat = Stat.new(@year)
    @stat.chapter = ::Chapter.find(params[:chapter_id]) if ((@chapter = params[:chapter_id]) and params[:chapter_id] != 'ALL')

    respond_to do |format|
      format.html
    end
  end

end
