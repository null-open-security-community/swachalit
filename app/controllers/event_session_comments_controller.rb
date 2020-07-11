class EventSessionCommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @event_session_comment = EventSessionComment.new(comment_params)

    @event_session_comment.save

    redirect_to controller: 'event_sessions', action: 'show', id: params[:event_session_comment][:event_session_id].to_i
  end

  def edit
    @event_session_comment = EventSessionComment.find(params[:id])
    @event_session = EventSession.find(@event_session_comment.event_session_id)

    respond_to do |format|
      format.html {redirect_to @event_session}
      format.js {render 'event_sessions/event_session_comments/edit_comment'}
    end
  end

  def update
    @event_session_comment = EventSessionComment.find(params[:id])
    @event_session = EventSession.find(@event_session_comment.event_session_id)

    @event_session_comment.update(comment_params)

    redirect_to event_session_path(@event_session)
  end

  def destroy
    @event_session_comment = EventSessionComment.find(params[:id])
    @event_session = EventSession.find(@event_session_comment.event_session_id)
    @event_session_comment.destroy

    redirect_to event_session_path(@event_session)
  end

  private

  def comment_params
    params.require(:event_session_comment).permit(:comment_body, :user_id, :event_session_id)
  end
end
