class Event < ActiveRecord::Base
  audited
  @queue = :event_jobs

  attr_accessible :name, :description, :event_type_id, :chapter_id, :venue_id
  attr_accessible :public, :can_show_on_homepage, :can_show_on_archive, :accepting_registration
  attr_accessible :state, :start_time, :end_time, :slug
  attr_accessible :registration_start_time, :registration_end_time, :registration_instructions
  attr_accessible :ready_for_announcement, :ready_for_notifications, :ready_for_reminders
  attr_accessible :notifications_sent_at, :announced_at
  attr_accessible :notification_state
  attr_accessible :max_registration
  attr_accessible :image

  validates :venue_id, :presence => true
  validates :chapter_id, :presence => true
  validates :event_type_id, :presence => true
  validates :name, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true

  validate :time_validator
  validate :chapter_validator

  # ActiveAdmin
  just_define_datetime_picker :start_time, :add_to_attr_accessible => true
  just_define_datetime_picker :end_time, :add_to_attr_accessible => true
  just_define_datetime_picker :registration_start_time, :add_to_attr_accessible => true
  just_define_datetime_picker :registration_end_time, :add_to_attr_accessible => true

  belongs_to :event_type
  belongs_to :chapter
  belongs_to :venue

  has_many :event_sessions, :dependent => :destroy
  has_many :event_registrations, :dependent => :destroy

  before_create :set_automatic_values!  # Defaults
  after_create  :slugify!
  after_create  :notify_admin_on_create
  after_save    :setup_scheduled_tasks, :if => lambda { public_changed? }

  scope :future_events, lambda { where('end_time > ?', Time.now) }
  scope :future_public_events, lambda { future_events.where(:public => true) }
  scope :public_events, lambda { where(public: true) }
  scope :archives, lambda { where('public = ? AND can_show_on_archive = ? AND start_time < ?', true, true, Time.now) }

  include Scheduler::ResqueSchedulerHelper
  delegate :url_helpers, to: 'Rails.application.routes'

  mount_uploader :image, ImageUploader

  def descriptive_name
    [
      'null',
      self.chapter.name,
      self.event_type.name,
      self.start_time.strftime('%d %B %Y'),
      self.read_attribute(:name)
    ].join(' ')
  end

  def as_json(options = {})
    super(:methods => [:event_type, :event_sessions])
  end

  # This JSON is used only for Event List view for client apps
  def to_brief_json
    ev = self

    {
      :id => ev.id,
      :event_type => self.event_type.name,
      :name => ev.name,
      :description => ev.description,
      :chapter_id => ev.chapter_id,
      :chapter => ev.chapter.name,
      :registration_count => ev.event_registrations.count,
      :start_time => ev.start_time,
      :end_time => ev.end_time
    }
  end

  ## Override self.name attribute read
  ## This is a bad idea - Results in crazy bugs
  # def name
  #   if self.new_record? or self.changed?
  #     super
  #   else
  #     self.descriptive_name
  #   end
  # end

  def descriptive_start_time
    self.start_time.strftime("%A %B %d %Y")
  end

  def invite_only?
    self.event_type.invitation_required?
  end

  def visible_registrations
    self.event_registrations.where(:visible => true)
  end

  def has_registration_instructions?
    !self.registration_instructions.to_s.empty?
  end

  def registration_allowed?
    if self.max_registration.to_i > 0
      self.max_registration.to_i > self.event_registrations.count
    else
      true
    end
  end

  def registration_active?
    return false unless self.accepting_registration?

    if self.registration_start_time and self.registration_end_time
      (Time.now > self.registration_start_time) and (Time.now < self.registration_end_time)
    else
      false
    end
  end

  def registerable_in_future?
    (self.accepting_registration?) and
      (self.registration_start_time) and
      (self.registration_start_time > Time.now)
  end

  def register_name
    if self.invite_only?
      "Register"
    else
      "RSVP"
    end
  end

  def to_param
    "#{self.id} #{self.chapter.name} #{self.name}".parameterize
    #self.name.parameterize + "/" + self.id.to_s
  end

  # ActiveRecord :on_create
  def slugify!
    self.slug = "#{self.chapter.name} #{self.name.parameterize} #{self.id}".parameterize
    #self.save()
  end

  def external_url()
    url_helpers.event_url(self)
  end

  # ActiveRecord :on_create
  def notify_admin_on_create
    notification_manager.admin_notify_on_create() unless disable_background_tasks?
  end

  def notification_manager
    ::EventNotification.find(self.id)
  end

  # State machine for notifications/reminders
  def execute_notifications
    notification_manager.initial_notifications() unless disable_background_tasks?
  end

  def execute_first_reminder
    notification_manager.reminder1() unless disable_background_tasks?
  end

  def execute_second_reminder
    notification_manager.reminder2() unless disable_background_tasks?
  end

  def execute_presentation_update_reminder
    notification_manager.speaker_presentation_update() unless disable_background_tasks?
  end

  def setup_scheduled_tasks
    return if disable_background_tasks?

    remove_scheduled_tasks()

    if self.public?
      add_scheduled_task(Time.now, :event_update_calendar)
      add_scheduled_task(Time.now, :execute_notifications) if self.ready_for_notifications?
      add_scheduled_task(self.start_time - 2.days, :execute_first_reminder) if self.ready_for_reminders?
      add_scheduled_task(self.start_time - 1.day, :execute_second_reminder) if self.ready_for_reminders?
      add_scheduled_task(self.end_time + 1.hour, :execute_presentation_update_reminder) if self.ready_for_reminders?
    end
  end

  #
  # START
  # Callback methods from scheduler
  #
  def event_update_calendar()
    c_event = ::GoogleAPI::CalendarEvent.new
    c_event.summary = self.chapter.name.to_s + ": " + self.name.to_s

    c_table = ""
    self.event_sessions.order('start_time ASC').each do |event_session|
      next if event_session.placeholder?
      c_table = c_table + event_session.name + " by " + event_session.user.name + " at " +
        event_session.start_time.strftime("%I:%M %p") + " - " +
        event_session.end_time.strftime("%I:%M %p") + "\n"
    end

    c_event.description = self.description.to_s + "\n\n" + c_table + "\n\nFor more details: " + url_helpers.event_url(self)
    c_event.start = self.start_time.to_datetime
    c_event.end = self.end_time.to_datetime

    client = ::GoogleAPI::ServiceClientFactory.get_instance(::GoogleAPI::CalendarV3::SCOPE_URL)
    calendar = ::GoogleAPI::CalendarV3.new(client, GOOGLE_API_CALENDAR_ID)

    if self.calendar_event_id.nil?
      response = calendar.insert_event(c_event)
      self.update_column(:calendar_event_id, response.id)   # We are in DB save callback
    else
      calendar.update_event(self.calendar_event_id, c_event)
    end
  end

  def to_ics_event
    c_event = ::Icalendar::Event.new
    c_event.dtstart = self.start_time
    c_event.dtend = self.end_time
    c_event.summary = self.descriptive_name
    c_event.description = self.description
    c_event.location = self.venue.map_url || self.venue.address
    c_event.created = self.created_at
    c_event.last_modified = self.updated_at
    c_event.uid = "swachalit-event-#{self.id}"
    c_event.url = url_helpers.event_url(self)
    c_event.organizer = Icalendar::Values::CalAddress.new("https://null.co.in", cn: 'null Open Security Community')

    return c_event
  end

  def disable_background_tasks?
    !! ENV["SWACHALIT_DISABLE_BACKGROUND_TASKS"]
  end

  #
  # END
  # Callback methods from scheduler
  #

  private

  def set_automatic_values!
    self.notification_state = EventNotification::STATE_INIT
    self.registration_start_time = self.start_time - 7.days if self.registration_start_time.nil?
    self.registration_end_time = self.start_time if self.registration_end_time.nil?
    self.max_registration = 0 if self.max_registration.nil?
    true # Must return true else record won't be saved
  end

  def time_validator
    errors.add(:start_time, 'cannot be nil') if self.start_time.nil?
    errors.add(:end_time, 'cannot be nil') if self.end_time.nil?
    errors.add(:start_time, 'cannot be in the past') if self.start_time && (self.start_time < Time.now)
    errors.add(:end_time, 'cannot be before start time') if (self.start_time && self.end_time) and (self.end_time < self.start_time)
  end

  def chapter_validator
    errors.add(:chapter, 'must be active') unless self.chapter&.active?
  end

end
