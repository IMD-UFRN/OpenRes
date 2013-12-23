OpenRes::Application.routes.draw do
  resources :room_types

  root to: 'home#index'

  devise_for :users
  resources :places
  resources :sectors
end
