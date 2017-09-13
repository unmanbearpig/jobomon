Rails.application.routes.draw do
  resources :feeds, only: [:index, :create, :show]
  resources :sources, only: [:index, :create, :show]
end
