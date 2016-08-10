Rails.application.configure do
  categories = YAML.load_file(Rails.root.join('config', 'categories.yml')).map{|k, v| [k.to_sym, v]}
  config.x.categories = categories.to_h
end
