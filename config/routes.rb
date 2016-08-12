Rails.application.routes.draw do
  root 'images#index'

  get 'images/judge'
  get 'images/result'
  resources :images, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
