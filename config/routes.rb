Rails.application.routes.draw do
  root 'application#root'

  scope :api do
    post '/user_token', to: 'user_token#create'
  end

  get '/*filename', to: 'application#public', as: :public
end
