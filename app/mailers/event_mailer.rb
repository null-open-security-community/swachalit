class EventMailer < ActionMailer::Base
  default :from => proc { CFG_MAILER_DEFAULT_FROM }
  add_template_helper(ApplicationHelper)

  class Helper
    include ApplicationHelper

    def self.safe_markdown_html(text)
      self.new().safe_markdown_html(text)
    end
  end

  def custom_mail(user, subject, body)
    mail(:to => user.email, :subject => subject) do |format|
      format.text { render :text => body }
      format.html { render :text => Helper.safe_markdown_html(body) }
    end
  end

  def announcement_mail(target, task)
    @event = task.event
    @task = task

    mail(:from => CFG_NOTIFICATION_ANNOUNCEMENT_SENDER_ADDRESSES, 
      :to => target, :subject => "[Announcement] #{@event.name}")
  end

  def reminder_mail(target, event)
    @event = event
    mail(:from => CFG_NOTIFICATION_ANNOUNCEMENT_SENDER_ADDRESSES,
      :to => target, :subject => "[Reminder] #{@event.name}")
  end

  def session_speaker_notification_mail(event_session)
    @ev_session = event_session
    mail(:to => @ev_session.user.email, :subject => "[Notification] Speaker for #{@ev_session.name}")
  end

  def session_speaker_reminder_mail(event_session)
    @ev_session = event_session
    mail(:to => @ev_session.user.email, :subject => "[Reminder] Speaker for #{@ev_session.name}")
  end

  def admin_on_create_notification_mail(target, event)
    @event = event
    mail(:to => target, :subject => "[Event Creation] New event created: #{event.name}")
  end

  def session_speaker_presentation_update_mail(event_session)
    @event_session = event_session
    mail(:to => event_session.user.email, :subject => "[Reminder] Presentation URL Update for: #{event_session.name}")
  end

  def rsvp_user_reminder_mail(user, event)
    @event = event
    mail(:to => user.email, :subject => "[null Event] Reminder: #{event.name}")
  end
end
