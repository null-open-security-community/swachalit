GrapeSwaggerRails.options.tap do |options|
  options.url      = '/api-v2/docs'
  options.app_url  = ''
  options.app_name = 'Swachalit'
  options.api_auth = 'bearer'
  options.api_key_name = 'Authorization'
  options.api_key_type = 'header'
end
