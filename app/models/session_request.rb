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
    self.chapter.leads.each do |n_user|
      MiscMailer.session_request_mail(n_user.email, self).deliver()
    end
  end

end
