Rails.application.configure do
  config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
  config.assets.precompile << ["*.svg", "*.eot", "*.woff", "*.ttf"]

  # Workaround for https://github.com/rails/sprockets/issues/581#issuecomment-486984663
  config.assets.configure do |env|
    env.export_concurrent = false
  end
end
