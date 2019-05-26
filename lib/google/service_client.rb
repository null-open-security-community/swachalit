module GoogleAPI
  
  CFG_PRIVATE_KEY_PATH      = ::GOOGLE_API_KEY_PATH
  CFG_PRIVATE_KEY_PHRASE    = ::GOOGLE_API_KEY_PASSPHRASE
  CFG_CLIENT_EMAIL          = ::GOOGLE_API_USER_EMAIL

  CFG_APPLICATION_NAME      = GOOGLE_API_APPLICATION_NAME
  CFG_APPLICATION_VERSION   = GOOGLE_API_APPLICATION_VERSION

  GOOGLE_API_CLIENT_USER_AGENT = "#{CFG_APPLICATION_NAME}/#{CFG_APPLICATION_VERSION} google-api-client"

  class ServiceClient
    attr_reader :client

    def initialize(scope)
      @scope = scope
      @client = ::Google::APIClient.new(:application_name => CFG_APPLICATION_NAME, 
        :application_version => CFG_APPLICATION_VERSION, :user_agent => GOOGLE_API_CLIENT_USER_AGENT)
    end

    def authorize()
      @key = Google::APIClient::PKCS12.load_key(CFG_PRIVATE_KEY_PATH, CFG_PRIVATE_KEY_PHRASE)
      @asserter = Google::APIClient::JWTAsserter.new(CFG_CLIENT_EMAIL, @scope, @key)
      @client.authorization = @asserter.authorize()
    end

    def method_missing(*args)
      method_name = args.shift
      @client.send(method_name.to_sym, *args)
    end
  end

  class ServiceClientFactory
    @@scoped_clients = {}

    def self.get_instance(scope)
      @@scoped_clients[scope] ||= new_authorized_instance(scope)
    end

    def self.new_authorized_instance(scope)
      client = ServiceClient.new(scope)
      client.authorize()

      return client
    end
  end

end