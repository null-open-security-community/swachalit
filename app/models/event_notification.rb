# This class extends Event and add the notification state machine to it
class EventNotification < ::Event
  @queue = :event_jobs

  STATE_INIT                      = "Init"
  STATE_INITIAL_NOTIFICATIONS     = "InitialNotifications"
  STATE_FIRST_REMINDER            = "Reminder1"
  STATE_SECOND_REMINDER           = "Reminder2"
  STATE_PRESENTATION_UPDATE       = "Presentation Update"
  STATE_FINISHED                  = "Finished"

  state_machine :notification_state, :initial => STATE_INIT do
    before_transition STATE_INIT => STATE_INITIAL_NOTIFICATIONS do |event_notification|
      event_notification.announcement_notify()
      event_notification.speaker_notify()
      event_notification.twitter_notify()
    end

    before_transition STATE_INITIAL_NOTIFICATIONS => STATE_FIRST_REMINDER do |event_notification|
      event_notification.event_reminder1()
      event_notification.speaker_reminder1()
      event_notification.twitter_reminder1()
    end

    before_transition STATE_FIRST_REMINDER => STATE_SECOND_REMINDER do |event_notification|
      event_notification.event_reminder2()
      event_notification.speaker_reminder2()
      event_notification.twitter_reminder2()
    end

    before_transition STATE_SECOND_REMINDER => STATE_PRESENTATION_UPDATE do |event_notification|
      event_notification.speaker_reminder_presentation_update()
    end

    event :initial_notifications do
      transition STATE_INIT => STATE_INITIAL_NOTIFICATIONS
    end

    event :reminder1 do
      transition STATE_INITIAL_NOTIFICATIONS => STATE_FIRST_REMINDER
    end

    event :reminder2 do
      transition STATE_FIRST_REMINDER => STATE_SECOND_REMINDER
    end

    event :speaker_presentation_update do
      transition STATE_SECOND_REMINDER => STATE_PRESENTATION_UPDATE
    end
  end

  # XXX: State is initialized at event.rb in set_automatic_values!

  def event
    @event ||= ::Event.find(self.id)
  end

  def announcement_notify()
    EventAutomaticNotificationTask.new do |en|
      en.event = self.event()
      en.mode = EventAutomaticNotificationTask::MODE_EVENT_ANNOUNCEMENT
      en.save!
    end
  end

  def speaker_notify()
    EventAutomaticNotificationTask.new do |en|
      en.event = self.event()
      en.mode = EventAutomaticNotificationTask::MODE_SPEAKER_NOTIFICATION
      en.save!
    end
  end

  def speaker_reminder1
    EventAutomaticNotificationTask.new do |en|
      en.event = self.event()
      en.mode = EventAutomaticNotificationTask::MODE_SPEAKER_REMINDER
      en.save!
    end
  end

  def speaker_reminder2
  end

  def event_reminder1
    EventAutomaticNotificationTask.new do |en|
      en.event = self.event()
      en.mode = EventAutomaticNotificationTask::MODE_EVENT_REMINDER
      en.save!
    end
  end

  def event_reminder2
    EventAutomaticNotificationTask.new do |en|
      en.event = self.event()
      en.mode = EventAutomaticNotificationTask::MODE_EVENT_REMINDER_FINAL
      en.save!
    end
  end

  def twitter_notify()
    m = "[Announcement] #{self.event.descriptive_name[0 ... 100]} #{self.event.external_url}"
    ::IftttMailer.twitter_status_update(m).deliver_now!()
  end

  def twitter_reminder1()
    m = "[Reminder] #{self.event.descriptive_name[0 ... 100]} #{self.event.external_url}"
    ::IftttMailer.twitter_status_update(m).deliver_now!()
  end

  def twitter_reminder2()
    m = "[Reminder] #{self.event.descriptive_name[0 ... 100]} #{self.event.external_url}"
    ::IftttMailer.twitter_status_update(m).deliver_now!()

    self.event.event_sessions.each do |event_session|
      next if event_session.placeholder?

      # Check if speaker has Twitter handle and send tagged announcement
      if (h = event_session.user.twitter_handle_name.to_s).present?
        m = "[Reminder] @#{h} speaking on #{event_session.name[0 ... 60]} #{self.event.external_url}"
        ::IftttMailer.twitter_status_update(m).deliver_now!()
      end
    end
  end

  def admin_notify_on_create
    EventAutomaticNotificationTask.new do |en|
      en.event = self.event()
      en.mode = EventAutomaticNotificationTask::MODE_ADMIN_CREATE_NOTIFICATION
      en.save!
    end
  end

  def speaker_reminder_presentation_update
    EventAutomaticNotificationTask.new do |en|
      en.event = self.event()
      en.mode = EventAutomaticNotificationTask::MODE_SPEAKER_PRESENTATION_UPDATE
      en.save!
    end
  end

end
