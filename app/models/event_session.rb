class EventSession < ActiveRecord::Base
  audited

  # Time window after end time till when this session is editable
  EDIT_WINDOW = 30.days

  attr_accessible :event_id, :user_id, :name, :description
  attr_accessible :session_type, :tags
  attr_accessible :need_projector, :need_microphone, :need_whiteboard
  attr_accessible :start_time, :end_time, :slug
  attr_accessible :tag_ids
  attr_accessible :presentation_url
  attr_accessible :video_url
  attr_accessible :placeholder
  attr_accessible :image

  # This is required to skip validation for admin user
  attr_accessor :is_admin_update

  # For ActiveAdmin
  # https://github.com/saepia/just-datetime-picker
  just_define_datetime_picker :start_time, :add_to_attr_accessible => true
  just_define_datetime_picker :end_time, :add_to_attr_accessible => true

  acts_as_taggable
  acts_as_votable

  belongs_to :event
  belongs_to :user

  has_many :event_session_comments

  validates :event_id, :user_id, :name, :description, :presence => true
  validates :start_time, :end_time, :presence => true
  validate :date_time_validator, :unless => :is_admin_update

  mount_uploader :image, ImageUploader

  scope :public_sessions, lambda {
    joins(:event).where(:events => { :public => true })
  }

  scope :has_a_reference, lambda {
    where('NOT(presentation_url IS NULL AND video_url IS NULL)'). \
    where("NOT(presentation_url = '' AND video_url = '')")
  }

  def initialize(*args)
    super(*args)

    unless self.event.nil?
      self.start_time = self.event.start_time if self.start_time.nil?
      self.end_time = self.event.end_time if self.end_time.nil?
    end
  end

  # Finder method to find a session for comments
  # This allow us scope for restricting comments with settings
  def self.find_for_comments(id)
    EventSession.find(id)
  end

  def self.find_for_voting(id)
    EventSession.find(id)
  end

  def as_json
    super(:only => [:id, :name, :description, :session_type, :tags, :start_time, :end_time,
      :presentation_url, :video_url], :methods => [ :user ])
  end

  def speaker
    self.user
  end

  def speaker_name
    self.speaker.name rescue ''
  end

  def to_param
    "#{self.id} #{self.name}".parameterize
  end

  private

  def date_time_validator
    if self.start_time and self.end_time
      errors.add(:start_time, 'cannot be before event start') if self.event.start_time > self.start_time
      errors.add(:end_time, 'cannot be after event end') if self.event.end_time < self.end_time
      errors.add(:end_time, 'cannot modify beyond 30 days after Event End Time') \
        if Time.now > (self.event.end_time + EDIT_WINDOW)
    end
  end

end
