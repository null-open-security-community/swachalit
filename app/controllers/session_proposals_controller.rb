class SessionProposalsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page = (params[:page] || 1).to_i
    @per_page = 10

    @session_proposals = session_proposals_for_user
    @session_proposals = @session_proposals.where(user_id: params[:user_id]) \
      if params[:user_id].present?

    @session_proposals = @session_proposals.page(@page).per(@per_page)

    respond_to do |format|
      format.html
    end
  end

  def new
    @session_proposal = ::SessionProposal.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @session_proposal = current_user.session_proposals.find(params[:id])

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

  def update
    @session_proposal = current_user.session_proposals.find(params[:id])

    respond_to do |format|
      if @session_proposal.update_attributes(params[:session_proposal])
        format.html do
          redirect_to session_proposal_path(@session_proposal), notice: 'Session proposal updated successfully'
        end
      else
        format.html do
          render :action => 'edit'
        end
      end
    end
  end

  def show
    @session_proposal = session_proposals_for_user.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  private

  def session_proposals_for_user
    SessionProposal.order('created_at DESC')
  end

end
