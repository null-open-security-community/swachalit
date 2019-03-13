class EventMailerTask < ActiveRecord::Base
  attr_accessible :subject, :body, :send_to_selected_only, :ready_for_delivery
  attr_accessible :executed, :event_id, :status, :registration_state

  belongs_to :event

  after_create :execute_task!
  after_update :execute_task!

  # Callback from Generic Background Task Worker
  def do_background()
    get_users().each do |user|
      EventMailer.custom_mail(user, self.subject.to_s, self.body.to_s).deliver!()
    end

    self.executed = true
    self.save!
  end

  private

  def get_users()
    ers = self.event.event_registrations
    #ers = ers.where(:accepted => true) if self.send_to_selected_only
    ers = ers.where(:state => self.registration_state) unless self.registration_state.to_s.empty?
    users = ers.map {|er| er.user }

    return users
  end

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
