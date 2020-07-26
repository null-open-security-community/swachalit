class EventSessionComment < ActiveRecord::Base
  
  validates :event_session_id, :user_id, :comment_body, :presence => true

end