# -*- encoding : utf-8 -*-
OpenRes::Application.routes.draw do
  get "map/show"
  resources :room_types

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get '/sobre', to: 'home#about', as: :about

  get '/new_reservation', to: 'reservations#select_reservation', as: :new_select_reservation

  get "reservations/all", to: "reservations#all", as: :all
  get "reservations/finished", to: "reservations#finished", as: :finished
  get "reservations/future", to: "reservations#future", as: :future

  get "reservations/basic_reservations", to: "reservations#user_all_reservations",as: :user_all_reservations
  get "reservations/basic_finished_reservations", to: "reservations#user_finished_reservations",as: :user_finished_reservations
  get "reservations/basic_future_reservations", to: "reservations#user_future_reservations",as: :user_future_reservations

  devise_for :users

  resources :sectors
  resources :reservations
  resources :user_places
  resources :object_resources

  get "check_reservations/", to: "reservation_approval#index", as: :check_reservations
  get "check_group_reservations/", to: "reservation_group_approval#index", as: :check_group_reservations



  post "reservation_groups/:reservation_group_id/approve", to: "reservation_group_approval#approve", as: :reservation_group_approve
  post "check_group_reservations/:reservation_group_id/reject", to: "reservation_group_approval#reject", as: :reservation_group_reject
  post "check_group_reservations/:reservation_group_id/suspend", to: "reservation_group_approval#suspend", as: :reservation_group_suspend
  post "reservation_groups/:reservation_group_id/cancel", to: "reservation_group_approval#cancel", as: :reservation_group_cancel


  get "reservations_group/:reservation_group_id/reject" => 'reservation_group_approval#justify_status', as: :justify_reject_group
  get "reservations_group/:reservation_group_id/suspend" => 'reservation_group_approval#justify_status', as: :justify_suspend_group


  post "reservations/:reservation_id/approve", to: "reservation_approval#approve", as: :reservation_approve
  post "check_reservations/:reservation_id/reject", to: "reservation_approval#reject", as: :reservation_reject
  post "check_reservations/:reservation_id/suspend", to: "reservation_approval#suspend", as: :reservation_suspend
  post "reservations/:reservation_id/cancel", to: "reservation_approval#cancel", as: :reservation_cancel

  get "reservations/:reservation_id/reject" => 'reservation_approval#justify_status', as: :justify_reject
  get "reservations/:reservation_id/suspend" => 'reservation_approval#justify_status', as: :justify_suspend

  get '/dashboard', to: 'dashboard#dashboard', as: :dashboard

  get '/places/preview/:id', to: 'reservations#preview', as: :place_preview

  get '/places/:id/get_reservations', to: 'places#get_reservations', as: :get_place_reservations

  get '/places/slot_search', to: 'places#slot_search', as: :slot_search
  
  resources :places


  resources :users, path: 'accounts'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user


  resources :reservation_groups, except: :destroy

  controller :profile do
    get '/profile/edit', to: 'profile#edit', as: :edit_profile
    get '/profile', to: 'profile#profile', as: :profile
    patch '/profile/edit', to: 'profile#update'
  end

  controller :checkin do
    get '/checkin', to: :index, as: :checkin_list
    get "checkin/:place_id", to: :checkin_details, as: :checkin_details
    post "checkin/:reservation_id", to: :checkin, as: :checkin
    post "checkout/:checkin_id", to: :checkout, as: :checkout
  end
end
