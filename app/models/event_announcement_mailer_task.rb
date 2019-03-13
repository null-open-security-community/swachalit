class EventAnnouncementMailerTask < ActiveRecord::Base
  attr_accessible :event_id, :recipients, :head_note, :foot_note, :ready_for_delivery, :executed
  attr_accessible :status

  belongs_to :event

  after_create :execute_task!
  after_update :execute_task!

  # Callback from Generic Background Task Worker
  def do_background()
    self.recipients.split(/(\n|\r)/).map(&:strip).each do |target|
      EventMailer.announcement_mail(target, self).deliver!() if target =~ ::Devise::email_regexp
    end

    self.executed = true
    self.save!
  end

  private

  def execute_task!
    if (!self.executed?) and (self.ready_for_delivery?)
      worker = ::Worker::BackgroundJobWorker.new
      worker.model_name = self.class.to_s
      worker.model_id = self.id

      worker.submit!
    end

    true
  end
end
