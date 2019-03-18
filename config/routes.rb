Rails.application.routes.draw do
  root to: 'application#index'

  post '/user_token', to: 'user_token#create'
end
