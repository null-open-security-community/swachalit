class EventType < ActiveRecord::Base
  audited
  
  attr_accessible :name, :description, :max_participant, :public
  attr_accessible :registration_required, :invitation_required

  validates :name, :uniqueness => true

  has_many :events
end
