class UserApiToken < ActiveRecord::Base

  belongs_to :user

  validates :client_name, :presence => true
  validates :user_agent,  :presence => true
  validates :ip_address,  :presence => true
  validates :user,        :presence => true
  validates :token,       :uniqueness => true

  before_save :generate_token!

  def self.create_for_request(user, client_name, request)
    user.user_api_tokens.new do |uapi|
      uapi.client_name = client_name
      uapi.user_agent = request.user_agent
      uapi.ip_address = (request.headers["X-Real-IP"] || request.remote_ip)
      uapi.save!
    end
  end

  private

  def generate_token!
    self.token = Digest::SHA2.hexdigest("--%d-%s--" % [user.id, Devise.friendly_token]) if self.token.to_s.empty?
  end

end
