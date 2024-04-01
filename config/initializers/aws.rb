require 'aws-sdk-s3'

Aws.config.update({
  region: 'us-east-2',
  credentials: Aws::Credentials.new('AKIA2LZ6POUASKPCFBOB', 'zjtIeIJ5Mnfh9rnBi4WN40ExGWKwjLaalsrhdCK+')
})
