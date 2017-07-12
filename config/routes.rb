Rails.application.routes.draw do
  post 'signup', to: 'users#create'
  post 'auth/login', to: 'authentication#authenticate'

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show, :create]
    end
  end

end
