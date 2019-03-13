class ConfirmationsController < Devise::ConfirmationsController
  before_filter :devise_verify_captcha, :only => [ :create ]
end