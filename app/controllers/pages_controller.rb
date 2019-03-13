class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [ :show ]
  load_and_authorize_resource

  def show
    @page = ::Page.find(params[:id].to_i)

    respond_to do |format|
      format.html
    end
  end

  def edit
    @page = ::Page.find(params[:id].to_i)

    respond_to do |format|
      format.html
    end
  end

  def update
    @page = ::Page.find(params[:id].to_i)

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html do
          redirect_to page_path(@page), :notice => "Page updated successfully."
        end
      else
        format.html do
          render :action => 'edit'
        end
      end
    end
  end

end
