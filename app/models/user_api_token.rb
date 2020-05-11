class UserApiToken < ActiveRecord::Base

  belongs_to :user

  validates :client_name, :presence => true
  validates :user_agent,  :presence => true
  validates :ip_address,  :presence => true
  validates :user,        :presence => true
  validates :token,       :uniqueness => true
  validates :expire_at,   :presence =>true

  before_validation :generate_token!

  scope :active, -> { where('active = ? AND expire_at > ?', true, Time.now) }

  DEFAULT_EXPIRY_TIME = 1.day

  def self.create_for_request(user, client_name, request)
    create_for_user(user, client_name, request.user_agent,
      request.headers["X-Real-IP"] || request.remote_ip)
  end

  def self.create_for_user(user, client_name, user_agent, origin_ip)
    user.user_api_tokens.new do |uapi|
      uapi.client_name = client_name
      uapi.user_agent = user_agent
      uapi.ip_address = origin_ip
      uapi.expire_at = Time.now + DEFAULT_EXPIRY_TIME

      uapi.save!
    end
  end

  def activate!
    active = true
    save!
  end

  private

  def generate_token!
    self.token = Digest::SHA2.hexdigest("--%d-%s--" % [user.id, Devise.friendly_token]) if self.new_record?
  end

end
