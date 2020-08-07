class EventSessionCommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @event_session_comment = EventSessionComment.new(comment_params)
    @event_session = EventSession.find(params[:event_session_comment][:event_session_id].to_i)
    @event_session_comment.user = current_user
    if @event_session_comment.save
      redirect_to event_session_path(@event_session), :notice => "Comment added successfully"
    else
        redirect_to event_session_path(@event_session), :alert => "Failed to add comment"
    end
  end

  def edit
    @event_session_comment = EventSessionComment.find(params[:id])
    @event_session = EventSession.find(@event_session_comment.event_session_id)

    respond_to do |format|
      format.html {redirect_to @event_session}
      format.js {render 'edit_comment'}
    end
  end

  def update
    @event_session_comment = EventSessionComment.find(params[:id])
    @event_session = EventSession.find(@event_session_comment.event_session_id)

    if @event_session_comment.update(comment_params)
        redirect_to event_session_path(@event_session), :notice => "Comment updated successfully"
    else
        redirect_to event_session_path(@event_session), :alert => "Failed to update comment"
    end
  end

  def destroy
    @event_session_comment = EventSessionComment.find(params[:id])
    @event_session = EventSession.find(@event_session_comment.event_session_id)
    if @event_session_comment.destroy
      redirect_to event_session_path(@event_session), :notice => "Comment deleted successfully"
    else
        redirect_to event_session_path(@event_session), :alert => "Failed to delete comment"
    end
  end

  private

  def comment_params
    params.require(:event_session_comment).permit(:comment_body, :event_session_id)
  end
end
