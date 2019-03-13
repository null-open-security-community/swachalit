class SessionRequestsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @session_request = ::SessionRequest.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @session_request = ::SessionRequest.new(params[:session_request])
    @session_request.user = current_user

    respond_to do |format|
      format.html do
        if @session_request.save
          redirect_to session_request_path(@session_request), :notice => 'Session request created successfully.'
        else
          render :action => 'new'
        end
      end
    end
  end

  def show
    @session_request = ::SessionRequest.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
