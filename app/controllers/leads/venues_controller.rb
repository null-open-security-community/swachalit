class Leads::VenuesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @venues = current_user.managed_venues

    respond_to do |format|
      format.html
    end
  end

  def new
    @venue = ::Venue.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @venue = ::Venue.new(params[:venue])
    authorize! :create, @venue

    respond_to do |format|
      format.html do
        if @venue.save
          redirect_to leads_venue_path(@venue), :notice => "Venue created successfully."
        else
          render :action => 'new'
        end
      end
    end
  end

  def show
    @venue = current_user.managed_venues.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def edit
    @venue = current_user.managed_venues.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @venue = current_user.managed_venues.find(params[:id])
    @venue.assign_attributes(params[:venue])

    authorize! :update, @venue

    respond_to do |format|
      format.html do
        if @venue.save
          redirect_to leads_venue_path(@venue), :notice => "Venue updated successfully."
        else
          render :action => 'edit'
        end
      end
    end
  end

  def destroy
    @venue = current_user.managed_venues.find(params[:id])
    authorize! :destroy, @venue

    redirect_to leads_venues_path, :alert => 'Deletion is currently disabled.'
  end

end
