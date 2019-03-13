class EventRegistration < ActiveRecord::Base
  audited

  attr_accessible :visible
  attr_accessible :gov_id_type
  attr_accessible :gov_id_number

  GOV_ID_TYPE_PASSPORT            = 'Passport'
  GOV_ID_TYPE_PAN                 = 'PAN'
  GOV_ID_TYPE_DRIVING_LICENSE     = 'Driving License'
  GOV_ID_VOTER_ID                 = 'Voter ID'
  GOV_ID_TYPE_OTHER               = 'Other'

  GOV_ID_TYPE_ALL = [
    GOV_ID_TYPE_PASSPORT,
    GOV_ID_TYPE_PAN,
    GOV_ID_TYPE_DRIVING_LICENSE,
    GOV_ID_VOTER_ID,
    GOV_ID_TYPE_OTHER
  ]

  belongs_to :event
  belongs_to :user

  validates :event, :user, :presence => true
  validates :user_id, :uniqueness => { :scope => [:event_id], :message => 'has already registered for the event' }
  validate  :registration_validator

  #before_create :set_acceptance!  # DEPRECATED
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

  def set_state!(state)
    raise "Invalid State" unless STATE_ALL.include?(state)

    self.state = state
    self.save!
  end

  def confirmed?
    self.state == STATE_CONFIRMED
  end

  # DEPRECATED
  # def accepted!
  #   self.accepted = true
  #   self.save!
  # end

  # def rejected!
  #   self.accepted = false
  #   self.save!
  # end

  private

  def set_default_state!
    if self.event.invite_only?
      self.state = STATE_PROVISIONAL
    else
      self.state = STATE_CONFIRMED
    end
  end

  # By default we set acceptance for non invite only events
  # DEPRECATED
  # def set_acceptance!
  #   self.accepted = !self.event.invite_only?
  #   true  # This is required else record won't be saved if false is returned
  # end

  def registration_validator
    errors.add(:event, "registration not allowed") unless event.registration_allowed? and event.registration_active?
  end
end
