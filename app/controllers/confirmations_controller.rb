class ConfirmationsController < Devise::ConfirmationsController
  before_filter :devise_verify_captcha, :only => [ :create ], :unless => proc { Rails.env.test? }
end