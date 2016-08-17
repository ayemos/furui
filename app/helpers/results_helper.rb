module ResultsHelper
  def name_for_category(category)
    Rails.application.config.x.categories[category.to_sym] || category
  end
end
