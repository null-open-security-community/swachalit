class User < ActiveRecord::Base
  audited

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :homepage, :about_me, :twitter_handle, :facebook_profile
  attr_accessible :github_profile, :linkedin_profile, :handle, :avatar
  attr_accessible :unconfirmed_email

  validates :name, :presence => true

  acts_as_voter

  has_many :event_sessions, :dependent => :restrict_with_error
  has_many :event_registrations, :dependent => :restrict_with_error
  has_many :event_session_comments, :dependent => :restrict_with_error
  has_many :chapter_leads, :dependent => :destroy
  has_many :user_api_tokens, :dependent => :destroy
  has_many :user_auth_profiles, :dependent => :destroy

  before_save :delete_api_tokens_if_password_changed?
  #after_create :deliver_confirmation_mail!

  mount_uploader :avatar, AvatarUploader

  def as_json(**args)
    super(:only => [:id, :name])
  end

  def create_api_token(client_name, request)
    UserApiToken.create_for_request(self, client_name, request)
  end

  def registered_for_event?(ev)
    self.event_registrations.where(:event_id => ev.id).count() > 0
  end

  def registration_for_event(ev)
    self.event_registrations.where(:event_id => ev.id).first()
  end

  def has_twitter_handle?
    !self.twitter_handle.to_s.empty?
  end

  def twitter_handle_name
    h = nil
    if self.twitter_handle.to_s.strip =~ /https?:\/\/(www\.)?twitter\.com\/(.*)/
      h = $2.to_s
    elsif self.twitter_handle.to_s.strip =~ /twitter\.com\/([a-zA-Z0-9_]+)/
      h = $1.to_s
    elsif self.twitter_handle.to_s.strip =~ /^@(.*)/
      h = $1.to_s
    else
      h = self.twitter_handle.to_s.strip
    end
    return h
  end

  def has_facebook_profile?
    !self.facebook_profile.to_s.empty?
  end

  def has_github_profile?
    !self.github_profile.to_s.empty?
  end

  def has_homepage?
    !self.homepage.to_s.empty?
  end

  def speaker_sessions
    EventSession.where(:user_id => self.id).where(:placeholder => false).order('created_at DESC')
  end

  def registered_participation
    self.event_registrations.
      where('accepted = ? OR state = ?', true, EventRegistration::STATE_CONFIRMED).
      order('created_at DESC')
  end

  def can_edit_event_session?(ev_session)
      (ev_session.user) &&
      (ev_session.user.id == self.id) &&
      (ev_session.start_time) &&
      (Time.now < (ev_session.start_time + EventSession::EDIT_WINDOW))
  end

  def chapter_leadership_history
    ChapterLead.leadership_for_user(self)
  end

  def is_leader?
    managed_chapters.count > 0
  end

  def managed_venues
    ::Venue.where(:chapter_id => self.managed_chapters.map(&:id))
  end

  def managed_chapters
    self.chapter_leads.where(:active => true).map(&:chapter)
  end

  def managed_events
    Event.future_events.where(:chapter_id => self.managed_chapters.map(&:id))
  end

  def managed_old_events
    Event.where(:chapter_id => self.managed_chapters.map(&:id)).
      where('end_time < ?',  (Time.now - 8.hours)).
      where('start_time > ?', (Time.now - 30.days))
  end

  def managed_chapter?(chapter)
    return false if chapter.nil? or (!chapter.is_a?(::Chapter))
    self.managed_chapters.map(&:id).include?(chapter.id)
  end

  def managed_venue?(venue)
    return false if venue.nil? or (!venue.is_a?(::Venue))
    self.managed_chapters.map(&:id).include?(venue.chapter_id)
  end

  def to_param
    "#{self.id} #{self.name}".parameterize
  end

  def gravatar_url
    g_hash_code = Digest::MD5.hexdigest(self.email.to_s.strip.downcase)
    "https://secure.gravatar.com/avatar/#{g_hash_code}"
  end

  def delete_api_tokens_if_password_changed?
    if encrypted_password_changed?
      self.user_api_tokens.destroy_all()
    end

    true
  end

  # Devise stopped sending initial confirmation mail after Rails 4.x upgrade
  # Here we force confirmation mail delivery if not already delivered
  # def deliver_confirmation_mail!
  #   unless self.confirmation_sent_at
  #     self.send_confirmation_instructions()
  #   end

  #   true
  # end

end
