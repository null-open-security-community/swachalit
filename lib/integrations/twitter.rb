module Integrations
  class TwitterClient
    def initialize(*args)
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = CFG_TWITTER_CONSUMER_KEY
        config.consumer_secret = CFG_TWITTER_CONSUMER_SECRET
        config.access_token = CFG_TWITTER_ACCESS_TOKEN
        config.access_token_secret = CFG_TWITTER_ACCESS_TOKEN_SECRET
      end
    end

    def update(msg)
      @client.update(msg)
    end

    def method_missing(*args)
      s = args.shift
      @client.send(s, *args)
    end
  end

  class TwitterFactory
    @@client = nil

    def self.get_instance()
      @@client ||= TwitterClient.new()
    end
  end
end