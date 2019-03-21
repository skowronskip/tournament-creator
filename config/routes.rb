Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :participants, only: [:index, :create, :destroy, :update, :test]
      resources :matches, only: [:index, :create, :destroy, :update]
      resources :tournaments, only: [:index, :create, :destroy, :update]
      post '/matches/generate', to: 'matches#generate_matches'
    end
  end
end