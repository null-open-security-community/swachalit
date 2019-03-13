class ApiController < ApplicationController
  before_filter :token_authenticate_user!, :only => [:check_authentication, :user_registrations]

  def authenticate
    user = User.find_for_authentication(:email => params[:email])
    if (!user.nil?) and (user.valid_password?(params[:password]))
      api_token = user.create_api_token(params[:client_name], request)
      render :json => { :error => "Success", :access_token => api_token.token }, :status => 200
    else
      render :json => { :error => "Authentication failed" }, :status => 401
    end
  end

  def check_authentication
    if user_signed_in?
      render :json => { "error" => "Success" }
    else
      render :json => { "error" => "Invalid user" }, :status => 401
    end
  end

  def user_registrations
    if user_signed_in?
      @event_registrations = current_user.event_registrations
      @event_registrations = @event_registrations.where(:event_id => params[:event_id]) if params[:event_id]
    else
      @event_registrations = []
    end

    render :json => @event_registrations
  end

  def user_autocomplete
    unless user_signed_in? or admin_user_signed_in?
      render :json => { :error => 'Authentication required' }, :status => 401
      return
    end

    unless admin_user_signed_in? or current_user.is_leader?
      render :json => { :error => 'Restricted API' }, :status => 403
      return
    end

    @users = User.where("name LIKE ? OR email LIKE ?", 
      "%" + params[:q].to_s + "%",
      "%" + params[:q].to_s + "%").limit(10)
    
    # https://select2.org/data-sources/formats
    render :json => {
      results: @users.map {|u| { :id => u.id, :text => "#{u.name} <#{u.email}>" } },
      pagination: {
        more: false
      }
    }
  end

end
