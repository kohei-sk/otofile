unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: "AKIA3DOUB5V62J4W37OB",
      aws_secret_access_key: "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",
      region: "ap-northeast-1",
    }

    config.fog_directory = "otofile"
    config.cache_storage = :fog
  end
end
