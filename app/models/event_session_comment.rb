class EventSessionComment < ActiveRecord::Base
  belongs_to :event_session
  belongs_to :user

  validates :event_session_id, :user_id, :comment_body, :presence => true
end