class Leads::ChaptersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @chapters = current_user.managed_chapters

    respond_to do |format|
      format.html
    end
  end

  def edit
    @chapter = Chapter.find(params[:id])
    authorize! :update, @chapter

    respond_to do |format|
      format.html
    end
  end

  def update
    @chapter = Chapter.find(params[:id])

    attrs_to_update = params[:chapter]
    attrs_to_update.delete(:active)
    attrs_to_update.delete(:code)

    @chapter.assign_attributes(attrs_to_update)
    authorize! :update, @chapter

    respond_to do |format|
      format.html do
        if @chapter.save
          redirect_to leads_chapters_path(), :notice => "Chapter updated successfully."
        else
          render :action => 'edit'
        end
      end
    end
  end

end
