class SessionProposal < ActiveRecord::Base
  attr_accessible :session_topic, :session_description, :user_id, :chapter_id, :event_type_id

  belongs_to :user
  belongs_to :chapter
  belongs_to :event_type

  validates :user, :presence => true
  validates :chapter, :presence => true
  validates :event_type, :presence => true
  validates :session_topic, :presence => true
  validates :session_description, :presence => true

  after_create :notify_users

  private

  def notify_users
    target_emails = self.chapter.leads.map do |n_user|
      n_user.email
    end

    MiscMailer.session_proposal_mail(target_emails, self).deliver_now()
  end

end
