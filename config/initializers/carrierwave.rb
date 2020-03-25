CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = "fog/aws"
    config.fog_credentials = {
      :provider              => CFG_STORAGE_PROVIDER,
      :aws_access_key_id     => CFG_STORAGE_ACCESS_KEY,
      :aws_secret_access_key => CFG_STORAGE_SECRET_KEY,
      :region                => CFG_STORAGE_REGION
    }

    config.fog_directory    = CFG_STORAGE_BUCKET
    config.fog_public = false
    config.fog_authenticated_url_expiration = (60 * 10)
  end
end