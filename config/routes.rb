Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :participants, only: [:index, :create, :destroy, :update, :test]
      resources :matches, only: [:index, :create, :destroy, :update]
      resources :tournaments, only: [:index, :create, :destroy, :update]

      #Matches Routes
      post '/matches/generate', to: 'matches#generate_matches'
      get '/matches/tournament/:tournament_id', to: 'matches#tournament_matches'
    end
  end
end