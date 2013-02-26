CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: ENV['FOG_PROVIDER'],
    aws_access_key_id: ENV['FOG_PUBLIC_KEY'],
    aws_secret_access_key: ENV['FOG_SECRET_KEY']
  }

  config.fog_directory = 'swcsurfcamp'
  config.fog_public = 'false'

end
