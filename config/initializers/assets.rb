Rails.application.configure do
  config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')  
  config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
end
