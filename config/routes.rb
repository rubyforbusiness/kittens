# frozen_string_literal: true

Rails.application.routes.draw do
  resources :flight_plans
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/flight_plans/delete_all', to: 'flight_plans#delete_all'
  post '/flight_plans/download', to: 'flight_plans#download'
  post '/flight_plans/:id/run', to: 'flight_plans#run', as: 'run_flight_plan'
  post '/flight_plans/:id/submit', to: 'flight_plans#submit', as: 'submit_flight_plan'

  get '/test_api/*email/directions', to: 'test_api#directions'
  get '/test_api/*email/location/*x/*y', to: 'test_api#location'
end
