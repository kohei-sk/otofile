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
      aws_access_key_id: "AKIA3DOUB5V62J4W37OB",
      aws_secret_access_key: "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",
      region: "ap-northeast-1",
    }
  end
end
