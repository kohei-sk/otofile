CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  else
    config.storage :fog
    config.fog_provider = "fog/aws"
    config.fog_directory = "otofile"
    config.asset_host = "https://s3.amazonaws.com/otofile"
    config.fog_public = false
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      region: "ap-northeast-1",
    }
  end
end
