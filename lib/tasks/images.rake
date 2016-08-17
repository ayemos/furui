require 'fileutils'
require 'find'
require 'aws_util'

IMAGE_BASE_PATH = 'public/images'

namespace :images do
  desc "Create records for local images"
  task :create_records_for_local_images, [:name, :path_to_image_directory] => :environment do |t, args|
    if ImageSet.exists?(name: args[:name])
      puts "Image set named #{args[:name]} already exists."
      puts "Do you want to add images to it?(y/n)"

      unless %w(y Y yes YES Yes).include?(STDIN.gets().strip)
        return
      end
    end

    paths = []

    Find.find(File.expand_path(args[:path_to_image_directory])) do |path|
      if File.file?(path) && Regexp.new('.(jpg|gif|png)$').match(path)
        paths << path
        puts "Found: #{path}"
      end
    end

    unless paths.empty?
      puts '-------------------------------------'
      puts "Should I make #{paths.count} records for them? (y/n)"

      if %w(y Y yes YES Yes).include?(STDIN.gets().strip)
        image_set = ImageSet.where(name: args[:name]).first_or_create
        image_path = Rails.root.join(IMAGE_BASE_PATH, args[:name])
        FileUtils.mkdir(image_path) unless File.directory?(image_path)

        paths.each do |path|
          puts "Saving: #{path}"
          image_set.images << LocalImage.new(
            category: :unknown,
            path: path
          )

          FileUtils.cp_r(path, Rails.root.join(IMAGE_BASE_PATH, args[:name], File.basename(path)))
        end
      end
    end
  end

  desc "Create records for s3 images"
  task :create_records_for_s3_images, [:name, :bucket_name, :prefix, :max_num] => :environment do |t, args|
    if ImageSet.exists?(name: args[:name])
      puts "Image set named #{args[:name]} already exists."
      puts "Do you want to add images to it?(y/n)"

      unless %w(y Y yes YES Yes).include?(STDIN.gets().strip)
        return
      end
    end

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
        image_set = ImageSet.create(name: args[:name])

        keys.each do |key|
          image_set.images << S3Image.new(
            category: :unknown,
            bucket_name: args[:bucket_name],
            key: key
          )
        end
      end
    end
  end

  desc "Export results for image set"
  task :export, [:name, :format] => :environment do |t, args|
    format = args[:format] || 'csv'
    images = ImageSet.where(name: args[:name]).first.images.where('category <> ?', Image.categories[:unknown])

    if format == 'yaml'
      puts images.to_yaml
    elsif format == 'json'
      puts images.to_json
    end
  end
end
