class SessionRequest < ActiveRecord::Base
  attr_accessible :chapter_id, :session_topic, :session_description

  belongs_to :chapter
  belongs_to :user

  validates :chapter, :presence => true
  validates :user,    :presence => true
  validates :session_topic, :presence => true
  validates :session_description, :presence => true

  after_create :notify_users

  private

  def notify_users
    target_emails = self.chapter.leads.map do |n_user|
      n_user.email
    end

    MiscMailer.session_request_mail(target_emails, self).deliver_now()
  end

end
