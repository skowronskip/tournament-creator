Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :participants, only: [:index, :create, :destroy, :update, :test]
      resources :matches, only: [:index, :create, :destroy, :update]
      resources :tournaments, only: [:index, :create, :destroy, :update]
      resources :games, only: [:index]

      #Users Routes
      post '/users/register', to: 'users#register'
      post '/users/login', to: 'users#login'
      get '/users/test', to: 'users#test'

      #Matches Routes
      post '/matches/generate', to: 'matches#generate_matches'
      get '/matches/tournament/:tournament_id', to: 'matches#tournament_matches'

      #Participants Routes
      get '/participants/statistics/:team_id', to: 'participants#team_statistics'

      #Tournament Routes
      get '/tournaments/statistics/:tournament_id', to: 'tournaments#tournament_statistics'
      get '/tournaments/myTournaments', to: 'tournaments#get_my_tournaments'
    end
  end
end