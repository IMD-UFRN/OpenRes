# -*- encoding : utf-8 -*-
OpenRes::Application.routes.draw do
  resources :room_types

  root to: 'home#index'

  devise_for :users
  resources :places
  resources :sectors
  resources :reservations

  get "check_reservations/", to: "reservation_approval#index", as: :check_reservations
  
  post "reservations/:reservation_id/approve", to: "reservation_approval#approve", as: :reservation_approve
  post "check_reservations/:reservation_id/reject", to: "reservation_approval#reject", as: :reservation_reject
  post "check_reservations/:reservation_id/set_pending", to: "reservation_approval#set_pending", as: :reservation_set_pending

  get '/dashboard', to: 'dashboard#dashboard', as: :dashboard

  resources :users
end
