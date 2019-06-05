Rails.application.routes.draw do
  devise_for :users
  root to: "home#show"
  get 'set_status', to: 'home#set_status'

  resources :users do
    get :connections, on: :collection
  end

  resources :chats do
    put :seen, on: :member
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
