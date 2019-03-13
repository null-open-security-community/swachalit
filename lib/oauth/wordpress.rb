require 'multi_json'

class OmniAuth::Strategies::Wordpress < OmniAuth::Strategies::OAuth2
  option :name, "wordpress"
  option :client_options, {
      :site => "http://staging.null.co.in",
      :authorize_url => '/oauth/authorize',
      :token_url => '/oauth/request_token'
  }

  option :token_params, {
      :parse => :json
  }

  uid { access_token.params['blog_id'] }

  info do
    {
        :uid => access_token.params['blog_id'],
        :blog_url => access_token.params['blog_url'],
        :nickname => raw_info['username'],
        :name => raw_info['display_name'],
        :user_id => access_token['ID'],
        :image => raw_info['avatar_URL'],
        :website => raw_info['profile_URL'],
        :email => raw_info['email']
    }
  end

  extra do
    {'raw_info' => raw_info.merge(access_token.params)}
  end

  def raw_info
    @raw_info ||= MultiJson.decode(access_token.get('/rest/v1/me').body)
   rescue ::Errno::ETIMEDOUT
     raise ::Timeout::Error
   end
end