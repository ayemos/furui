Rails.application.routes.draw do
  root 'image_sets#index'

  resources :results, only: [:index, :show]

  resources :image_sets, only: [:index, :show]

  get 'images/judge'
end
