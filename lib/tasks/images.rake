require 'find'
require 'aws_util'

IMAGE_BASE_PATH = 'public/images'

namespace :images do
  desc "Create records for local images"
  task :create_records_for_local_images, [:path_to_image_directory] => :environment do |t, args|
    paths = []

    Find.find(Rails.root.join(IMAGE_BASE_PATH, args[:path_to_image_directory])) do |path|
      if File.file?(path) && Regexp.new('.(jpg|gif|png)$').match(path)
        # /path/to/app/public/images/hoge.jpg => hoge.jpg
        base_path = path[(path.index(IMAGE_BASE_PATH) + IMAGE_BASE_PATH.length + 1)..path.length - 1]
        paths << base_path
        puts "Found: #{base_path}"
      end
    end

    unless paths.empty?
      puts '-------------------------------------'
      puts "Should I make #{paths.count} records for them? (y/n)"

      if %w(y Y yes YES Yes).include?(STDIN.gets().strip)
        paths.each do |path|
          Image.create(
            category: :unknown,
            type: 'LocalImage',
            path: path
          )
        end
      end
    end
  end

  desc "Create records for s3 images"
  task :create_records_for_s3_images, [:bucket_name, :prefix, :max_num] => :environment do |t, args|
    keys = []
    max_num = (args[:max_num] || 10).to_i

    s3[:resource].bucket(args[:bucket_name]).objects(
      prefix: args[:prefix],
    ).limit(max_num).each do |obj|
      keys << obj.key
      puts "Found: #{obj.key}"
    end

    unless keys.empty?
      puts '-------------------------------------'
      puts "Should I make #{keys.count} records for them? (y/n)"

      if %w(y Y yes YES Yes).include?(STDIN.gets().strip)
        keys.each do |key|
          Image.create(
            category: :unknown,
            type: 'S3Image',
            bucket_name: args[:bucket_name],
            key: key
          )
        end
      end
    end
  end
end
