class EventAutomaticNotificationTask < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :event_id, :mode, :executed

  MODE_EVENT_ANNOUNCEMENT           = "Announcement"
  MODE_SPEAKER_NOTIFICATION         = "Speaker Notification"
  MODE_EVENT_REMINDER               = "Event Reminder"
  MODE_EVENT_REMINDER_FINAL         = "Event Reminder Final"
  MODE_SPEAKER_REMINDER             = "Speaker Reminder"
  MODE_ADMIN_CREATE_NOTIFICATION    = "Admin OnCreate Notification"
  MODE_SPEAKER_PRESENTATION_UPDATE  = "Speaker Presentation Update"

  MODE_ALL = self.constants.map {|e| self.const_get(e) if e.to_s =~ /^MODE_/ }.compact()

  belongs_to :event

  after_create :execute_task!
  after_update :execute_task!

  def do_background()
    case self.mode
    when MODE_EVENT_ANNOUNCEMENT
      event_announcement()

    when MODE_SPEAKER_NOTIFICATION
      speaker_notification()

    when MODE_EVENT_REMINDER
      event_reminder()

    when MODE_EVENT_REMINDER_FINAL
      rsvp_user_reminder()

    when MODE_SPEAKER_REMINDER
      speaker_reminder()

    when MODE_ADMIN_CREATE_NOTIFICATION
      admin_on_create_notify()

    when MODE_SPEAKER_PRESENTATION_UPDATE
      speaker_remind_presentation_update()
    end

    self.executed = true
    self.save!
  end

  private

  def event_announcement()
    CFG_NOTIFICATION_ANNOUNCEMENT_DEFAULT_ADDRESSES.each do |address|
      EventMailer.announcement_mail(address, self).deliver!()
    end
  end

  def speaker_notification()
    self.event.event_sessions.each do |ev_session|
      next if ev_session.placeholder?
      EventMailer.session_speaker_notification_mail(ev_session).deliver!()
    end
  end

  def event_reminder()
    CFG_NOTIFICATION_ANNOUNCEMENT_DEFAULT_ADDRESSES.each do |address|
      EventMailer.reminder_mail(address, self.event).deliver!()
    end
  end

  def speaker_reminder()
    self.event.event_sessions.each do |ev_session|
      next if ev_session.placeholder?
      EventMailer.session_speaker_reminder_mail(ev_session).deliver!()
    end
  end

  def rsvp_user_reminder()
    self.event.event_registrations.each do |registration|
      next unless registration.confirmed?
      EventMailer.rsvp_user_reminder_mail(registration.user, event).deliver() unless registration.user.nil?
    end
  end

  def admin_on_create_notify()
    targets = CFG_NOTIFICATION_ADMIN_EVENT_CREATE
    targets += self.event.chapter.leads.map {|u| u.email }
    targets = targets.uniq()

    targets.each do |t|
      EventMailer.admin_on_create_notification_mail(t, self.event).deliver!()
    end
  end

  def speaker_remind_presentation_update
    self.event.event_sessions.each do |ev_session|
      next if ev_session.placeholder?
      next unless ev_session.presentation_url.nil?
      EventMailer.session_speaker_presentation_update_mail(ev_session).deliver()
    end   
  end

  def execute_task!
    unless self.executed?
      worker = ::Worker::BackgroundJobWorker.new
      worker.model_name = self.class.to_s
      worker.model_id = self.id

      worker.submit!
    end

    true
  end
end
