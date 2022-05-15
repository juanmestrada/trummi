# CarrierWave.configure do |config|
#   config.storage    = :aws
#   config.aws_bucket = ENV.fetch('S3_BUCKET_NAME')
#   config.aws_acl    = 'public-read'
#   config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
#   config.aws_attributes = {
#     expires: 1.week.from_now.httpdate,
#     cache_control: 'max-age=604800'
#   }

#   config.aws_credentials = {
#     access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
#     secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
#     region:            ENV.fetch('AWS_REGION') # Required
#   }
# end
CarrierWave.configure do |config|
	config.fog_credentials = {
		:provider 				=> 'AWS',
		:aws_access_key_id 		=> ENV['AWS_ACCESS_KEY_ID'],
		:aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
		:region                 => 'us-west-1',
    	:endpoint               => 'https://s3-us-west-1.amazonaws.com/'
	}

	config.fog_directory = ENV['S3_BUCKET_NAME']
end