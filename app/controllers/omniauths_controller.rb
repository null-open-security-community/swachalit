class OmniauthsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :failure_callback]

  def create
    @auth_profile = UserAuthProfile.find_for_omniauth(auth_hash)

    begin
      @auth_profile = UserAuthProfile.create_for_omniauth(auth_hash) if @auth_profile.nil?
      @auth_profile.update_omniauth!(auth_hash)

      session[:current_auth_profile_id] = @auth_profile.id
      sign_in @auth_profile.user

      redirect_to '/'
    rescue => e
      render status: 400, text: "Failed to sign-in with #{params[:provider]}"
    end
  end

  def failure_callback
    render :text => "Failed to login with external provider"
  end

  private

  def auth_hash
    request.env['omniauth.auth'] || {}
  end
end
