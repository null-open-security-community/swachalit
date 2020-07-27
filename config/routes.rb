require 'resque'
require 'resque/server'
require 'resque/scheduler/server'

NullifyPlatform::Application.routes.draw do
  # For SEO
  get '/event/:name' => 'events#seo_name', :as => :event_friendly

  resources :event_mailer_tasks
  resources :user_achievements
  resources :event_sessions do
    collection do
      get 'my_sessions', as: :my
    end
    member do
      post "like", to: "event_sessions#like"
      post "dislike", to: "event_sessions#dislike"
    end
  end
  resources :event_session_comments, only:[:create, :edit, :update, :destroy]
  resources :session_requests
  resources :session_proposals
  resources :stats
  resources :pages

  #get '/events/:name/:id' => 'events#show'
  resources :events do
    resources :event_registrations
  end

  resources :event_types
  resources :venues
  resources :chapters do
    member do
      get 'leaders'
      get 'upcoming_events'
      get 'calendar.ics', action: 'calendar', :as => 'calendar'
    end
  end

  #get '/leads/events/:name/:id' => 'leads/events#show'
  namespace :leads do
    resources :events do
      resources :event_sessions do
        collection do
          get 'suggest_user'
        end
      end

      resources :event_registrations do
        collection do
          put 'mass_update'
          get 'export_csv'
        end
      end
      resources :event_mailer_tasks do
        member do
          get 'execute'   # CSRF?
        end
      end
    end

    resources :venues
    resources :chapters
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  devise_for :users, :controllers => {
    :registrations => 'registrations',
    :passwords => 'passwords',
    :confirmations => 'confirmations'
  }

  get '/signup/confirm' => 'home#signup_confirm', :as => :signup_confirm
  get '/upcoming'       => 'home#upcoming', :as => :upcoming
  get '/archives'       => 'home#archives', :as => :archives
  get '/about'          => 'home#about',    :as => :about
  get '/calendar'       => 'home#calendar', :as => :calendar
  get '/profile/:id'    => 'home#public_profile', :as => :public_profile
  get '/raise_exception_test' => 'home#raise_exception'
  get '/forum', :to => 'home#forum', :as => :forum
  get '/IRC', :to => 'home#IRC', :as => :irc
  get '/privacy', :to => 'home#privacy', :as => :privacy

  post '/api/authenticate'        => 'api#authenticate',          :as => :api_authentication
  post '/api/register'            => 'api#register',              :as => :api_registration
  get  '/api/is_authenticated'    => 'api#check_authentication',  :as => :api_is_authenticated
  get  '/api/user/registrations'  => 'api#user_registrations',    :as => :api_user_registrations
  get  '/api/user/autocomplete'   => 'api#user_autocomplete'

  post '/api/slackbot/events'     => 'integrations/slackbot#events',    :as => :api_slackbot_events

  ActiveAdmin.routes(self)

  # Omniauth Callback
  match '/auth/:provider/callback'  => 'omniauths#create', via: [:get, :post]

  # Resque Web
  # ResqueWeb::Engine.eager_load!

  # Mount Grape APIs
  mount ::API::Swachalit => '/api-v2'
  mount GrapeSwaggerRails::Engine, at: '/api-v2/swagger'

  authenticate :admin_user do
    #mount ResqueWeb::Engine, :at => '/admin/resque', :as => :resque
    mount Resque::Server.new, :at => '/admin/resque', :as => :resque
  end

  root :to => 'home#index'
end
