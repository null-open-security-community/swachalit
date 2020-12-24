class EventSessionComment < ActiveRecord::Base
  belongs_to :event_session
  belongs_to :user

  validates :event_session_id, :user_id, :comment_body, :presence => true

  attr_accessible :event_session_id
  attr_accessible :comment_body

  attr_readonly :user_id
  attr_readonly :event_session_id
end
