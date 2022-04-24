class ConfirmationsController < Devise::ConfirmationsController
  before_filter :devise_verify_captcha, :only => [ :create ], :unless => proc { Rails.env.test? }

  def show
    token = params[:confirmation_token]
    logger.debug("Token: #{token}")
    render :action => 'update', :confirmation_token => token
  end

  def update
    logger.debug("Post Token: #{params[:user][:confirmation_token]}")
    super.show do |user|
      logger.debug("User: #{user}")
      if user.valid_password?(params[:user][:password])
        user.confirm
      else
        user.errors.add(:user, :invalid_password)
      end
    end
  end
end