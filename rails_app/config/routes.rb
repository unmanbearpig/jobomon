Rails.application.routes.draw do
  scope '/api' do
    resources :feeds, only: [:index, :create, :show]
    resources :sources, only: [:index, :create, :show]
    resources :job_offers, only: [:index]
  end
end
