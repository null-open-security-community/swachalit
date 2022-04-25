class ConfirmationsController < Devise::ConfirmationsController
  before_filter :devise_verify_captcha, :only => [ :create ], :unless => proc { Rails.env.test? }

  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    if self.resource.confirmed?
      redirect_to new_user_session_path, :notice => find_message(:confirmed)
    end
  end

  def confirm    
    token = params[:user][:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token(token)
    
    if self.resource.valid_password?(params[:user][:password])
      #super.show   ## this is not working
      resource_class.confirm_by_token(token)
      redirect_to new_user_session_path, :notice => find_message(:confirmed)
    else
      redirect_to user_confirmation_path(:confirmation_token => token), alert: find_message(:invalid_password)
    end
  end
  
end