class PasswordsController < Devise::PasswordsController
  before_filter :devise_verify_captcha, :only => [ :create ]
end  