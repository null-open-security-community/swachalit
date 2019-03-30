config = YAML.load(File.read(File.join(Rails.root.to_s, "config/redis.yml")))
config.symbolize_keys!

Resque.redis = "#{config[:host]}:#{config[:port]}"
Resque.redis.namespace = "resque:#{config[:namespace]}"
Resque.inline = Rails.env.test?

