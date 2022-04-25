class ConfirmationsController < Devise::ConfirmationsController
  before_filter :devise_verify_captcha, :only => [ :create ], :unless => proc { Rails.env.test? }

  def show
    #@original_token = params[:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    logger.debug(self.resource.email)
  end

  def confirm
    #logger.debug("PATCH Token: #{params[:user][:confirmation_token]}")
    token = params[:user][:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token(token)
    #logger.debug('User: #{resource}')
    if self.resource.valid_password?(params[:user][:password])
      #super.show   ## this is not working
      self.resource_class.confirm_by_token(token)
      #set_flash_message!(:notice, :confirmed)
      redirect_to new_user_session_path, :notice => find_message(:confirmed)
    else
      set_flash_message!(:notice, :invalid_password)
      render :show, :notice => find_message(:confirmed)
      #redirect_to :action => 'show', :confirmation_token => token, :alert => find_message(:invalid_password)
      #render :action => "show", :alert => find_message(:invalid_password)
      #respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end
end