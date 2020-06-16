class EventRegistration < ActiveRecord::Base
  audited

  attr_accessible :visible

  belongs_to :event
  belongs_to :user

  validates :event, :user, :presence => true
  validates :user_id, :uniqueness => { :scope => [:event_id], :message => 'has already registered for the event' }
  validate  :new_registration_validator, :if => :new_record?

  before_create :set_default_state!

  STATE_PROVISIONAL   = "Provisional"
  STATE_CONFIRMED     = "Confirmed"
  STATE_NOT_ATTENDING = "Not Attending"
  STATE_ABSENT        = "Absent"

  STATE_ALL = [
    STATE_PROVISIONAL, STATE_CONFIRMED, STATE_NOT_ATTENDING, STATE_ABSENT
  ]

  scope :absent, lambda { where(:state => STATE_ABSENT) }

  def as_json(*args)
    super(:only => [:id, :event_id, :user_id, :accepted, :created_at, :updated_at, :state, :visible])
  end

  def set_state!(new_state)
    raise "Invalid State" unless STATE_ALL.include?(new_state)
    return if self.state == new_state

    self.state = new_state
    self.save!
  end

  def confirmed?
    self.state == STATE_CONFIRMED
  end

  private

  def set_default_state!
    if self.event.invite_only?
      self.state = STATE_PROVISIONAL
    else
      self.state = STATE_CONFIRMED
    end
  end

  def new_registration_validator
    errors.add(:event, "is not allowed") if !event.registration_allowed?
    errors.add(:event, "is not active") if !event.registration_active?
  end
end
