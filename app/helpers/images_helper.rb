require 'aws_util'

module ImagesHelper
  def image_tag_for_local_image(local_image)
    image_tag(local_image.path)
  end

  def image_tag_for_s3_image(s3_image)
    image_tag(url_for_s3_image(s3_image))
  end

  def color_for_category(category, brightness=nil)
    category_num = Image.categories[category.to_sym]

    r = (category_num * 31).hash % 128
    g = (r * r) % 128
    b = (g * g) % 128
    puts [r, g, b].to_s

    if brightness && brightness >= 0 && brightness <= 1
      pad = (128 * brightness).to_i

      r += pad
      g += pad
      b += pad
    end

    puts [r, g, b].to_s

    "##{r.to_s(16)}#{g.to_s(16)}#{b.to_s(16)}"
  end

  private
    def url_for_s3_image(s3_image)
      url_for_s3_resource(s3_image.bucket_name, s3_image.key)
    end

end
