class RegistrationsController < Devise::RegistrationsController
  before_filter :devise_verify_captcha, :only => [ :create ]
  
  def destroy
    redirect_to '/'
  end

  def after_inactive_sign_up_path_for(resource)
    '/signup/confirm'
  end

end
