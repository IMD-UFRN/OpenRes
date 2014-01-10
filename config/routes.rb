# -*- encoding : utf-8 -*-
OpenRes::Application.routes.draw do
  resources :room_types

  root to: 'home#index'

  get "reservations/all", to: "reservations#all", as: :all
  get "reservations/finished", to: "reservations#finished", as: :finished
  get "reservations/future", to: "reservations#future", as: :future

  get "reservations/basic_reservations", to: "reservations#user_all_reservations",as: :user_all_reservations
  get "reservations/basic_finished_reservations", to: "reservations#user_finished_reservations",as: :user_finished_reservations
  get "reservations/basic_future_reservations", to: "reservations#user_future_reservations",as: :user_future_reservations

  devise_for :users
  resources :places
  resources :sectors
  resources :reservations
  resources :user_places

  get "check_reservations/", to: "reservation_approval#index", as: :check_reservations

  post "reservations/:reservation_id/approve", to: "reservation_approval#approve", as: :reservation_approve
  post "check_reservations/:reservation_id/reject", to: "reservation_approval#reject", as: :reservation_reject
  post "check_reservations/:reservation_id/suspend", to: "reservation_approval#suspend", as: :reservation_suspend
  
  get "reservations/:reservation_id/reject" => 'reservation_approval#justify_status', as: :justify_reject
  get "reservations/:reservation_id/suspend" => 'reservation_approval#justify_status', as: :justify_suspend

  get '/dashboard', to: 'dashboard#dashboard', as: :dashboard


  resources :users
end
