require 'aws-sdk'

def s3
  {
    resource: @s3_resource ||= Aws::S3::Resource.new,
    client: @s3_client ||= Aws::S3::Client.new
  }
end

def url_for_s3_resource(bucket_name, key)
  s3[:resource].bucket(bucket_name).object(key).presigned_url(:get, expires_in: 1.hour)
end
