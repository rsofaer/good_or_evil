CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = 'goodevil'
  config.aws_acl    = :public_read
  config.asset_host = 'https://s3-us-west-1.amazonaws.com'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     'AKIAI6AECUXY23A6B56Q',
    secret_access_key: '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'
  }
end
