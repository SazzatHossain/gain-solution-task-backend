Rails.application.routes.draw do

  scope '/api' do
    namespace :v1, defaults: { format: :json } do
      resources :events do
        resources :rsvps
        get '/show-rsvp', to: "rsvps#show_rsvp"
     end
      resources :home, :path => '/', only: [:index]
      resources :users
      get '/user-data', to: 'users#show'
      get '/my-events-list', to: 'events#my_events_list'
      patch '/user-data-update', to: 'users#update'
      post '/sign-in', to: 'sessions#sign_in'
     end
  end
end
