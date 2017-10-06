Rails.application.routes.draw do
  scope '/api' do
    post 'user_token' => 'user_token#create'
    resources :users, only: [:create]
    resources :feeds, only: [:index, :create, :show]
    resources :sources, only: [:index, :create, :show]
    resources :job_offers, only: [:index]
  end
end
