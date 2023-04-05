
Rails.application.routes.draw do

  scope '/api' do
    namespace :v1, defaults: { format: :json} do
      resources :home, :path => '/', only: [:index]
      resources :users, :events
      get '/user-data', to: 'users#show'
      post '/sign-in', to: 'sessions#sign_in'
    end
  end
end
