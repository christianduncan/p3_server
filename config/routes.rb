Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
		namespace :v1 do
      resources :users
      post "/login", to: "auth#login"

      get "/auto_login", to: "auth#auto_login"
      
      resources :animals
      resources :shelters, only: [:index, :show]
		end
	end
end
