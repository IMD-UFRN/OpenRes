OpenRes::Application.routes.draw do

  devise_for :users
  resources :room_types
  resources :places
  resources :sectors
end
