class SessionProposalsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @session_proposal = ::SessionProposal.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @session_proposal = ::SessionProposal.new(params[:session_proposal])
    @session_proposal.user = current_user

    respond_to do |format|
      format.html do
        if @session_proposal.save
          redirect_to session_proposal_path(@session_proposal), :notice => 'Session proposal created successfully.'
        else
          render :action => 'new'
        end
      end
    end
  end

  def show
    @session_proposal = ::SessionProposal.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

end
