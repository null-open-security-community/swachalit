class UserAuthProfile < ActiveRecord::Base
  audited

  attr_accessible :uid, :provider, :oauth_data

  serialize :oauth_data
  serialize :extra
  
  belongs_to :user
  
  validates :uid, :presence => true
  validates :provider, :presence => true
  
  validates :uid, :uniqueness => { :scope => [:user_id, :provider ] }
  
  def initialize(*args)
    super(*args)
    self.extra ||= Hash.new
  end
  
  def self.find_for_omniauth(auth)
    u = ::User.where(:email => auth[:info][:email]).first()

    if u
      return u.
        user_auth_profiles.
          where(:uid => auth[:uid], :provider => auth[:provider]).
          first()
    end
    
    nil
  end
  
  def self.create_for_omniauth(auth)
    u = ::User.where(:email => auth[:info][:email]).first()

    if u.nil?
      u = User.new(:name => auth[:info][:name], :email => auth[:info][:email])
      u.password = u.password_confirmation = Devise.friendly_token[0, 20]
      
      # We don't need to confirm email when registering from external provider
      u.skip_confirmation!
      u.skip_confirmation_notification!

      u.save!
    end
    
    auth_profile = u.user_auth_profiles.where(:uid => auth[:uid], :provider => auth[:provider]).first()
    if auth_profile.nil?
      auth_profile = u.user_auth_profiles.create!({
        :uid => auth[:uid],
        :provider => auth[:provider],
        :oauth_data => auth
      })
    end
    
    return auth_profile
  end
  
  def update_omniauth!(auth)
    self.oauth_data = auth
    self.save!
  end

  def profile_image_url
    self.oauth_data.info.image rescue nil
  end

  def access_token
    self.oauth_data.credentials.token rescue nil
  end
  
  def id_token
    begin
      self.oauth_data.extra.id_token || self.oauth_data.extra.raw_info.id_token
    rescue
      nil
    end
  end
    
  def id_token_claims
    self.oauth_data.extra.raw_info.id_token_claims rescue nil
  end
  
  def roles
    id_token_claims.roles.to_a rescue []
  end
end
  