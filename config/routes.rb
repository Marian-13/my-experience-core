Rails.application.routes.draw do
  root 'application#root'

  get '/*filename', to: 'application#public', as: :public

  post '/user_token', to: 'user_token#create'
end
