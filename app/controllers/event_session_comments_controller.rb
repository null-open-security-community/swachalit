class EventSessionCommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @event_session_comment = EventSessionComment.new(comment_params)
    @event_session_comment.user = current_user

    if verify_recaptcha(model: @event_session_comment) && @event_session_comment.save
      redirect_to _event_session_path, :notice => "Comment added successfully"
    else
      redirect_to _event_session_path, :alert => "Failed to add comment"
    end
  end

  def edit
    @event_session_comment = current_user.event_session_comments.find(params[:id])

    respond_to do |format|
      format.html { redirect_to @event_session }
      format.js { render 'edit_comment' }
    end
  end

  def update
    @event_session_comment = current_user.event_session_comments.find(params[:id])

    if @event_session_comment.update(comment_params)
      redirect_to _event_session_path, :notice => "Comment updated successfully"
    else
      redirect_to _event_session_path, :alert => "Failed to update comment"
    end
  end

  def destroy
    @event_session_comment = current_user.event_session_comments.find(params[:id])

    if @event_session_comment.destroy
      redirect_to _event_session_path, :notice => "Comment deleted successfully"
    else
      redirect_to _event_session_path, :alert => "Failed to delete comment"
    end
  end

  private

  def _event_session_path
    event_session_path @event_session_comment.event_session
  end

  def comment_params
    params.require(:event_session_comment).permit(:comment_body, :event_session_id)
  end
end
