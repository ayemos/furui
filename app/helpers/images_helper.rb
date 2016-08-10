require 'aws_util'

module ImagesHelper
  def image_tag_for_local_image(local_image)
    image_tag(local_image.path)
  end

  def image_tag_for_s3_image(s3_image)
    image_tag(url_for_s3_image(s3_image))
  end

  private
    def url_for_s3_image(s3_image)
      url_for_s3_resource(s3_image.bucket_name, s3_image.key)
    end
end
