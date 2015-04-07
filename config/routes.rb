# -*- encoding : utf-8 -*-
OpenRes::Application.routes.draw do

  resources :class_monitors
  resources :drivers
  resources :object_resources
  resources :places
  resources :room_types
  resources :reservations
  resources :reservation_groups, except: :destroy
  resources :sectors
  resources :user_places
  resources :vehicle_reservations
  resources :vehicles

  devise_for :users

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  controller :profile do
    get '/profile/edit', to: 'profile#edit', as: :edit_profile
    get '/profile', to: 'profile#profile', as: :profile
    get '/profile/edit/password', to: 'profile#edit_password', as: :edit_password
    patch '/profile/edit', to: 'profile#update'
  end

  controller :checkin do
    get '/checkin', to: :index, as: :checkin_list
    get "checkin/:place_id", to: :checkin_details, as: :checkin_details
    post "checkin/:reservation_id", to: :checkin, as: :checkin
    post "checkout/:checkin_id", to: :checkout, as: :checkout
  end

  controller :reservation_groups do
    get '/reservation_groups/:id/new_reservation', to: :new_reservation, as: :add_reservation
  end

  get "map/show"
  get '/sobre', to: 'home#about', as: :about
  get '/novidades', to: 'home#whats_new', as: :whats_new
  get '/new_reservation', to: 'reservations#select_reservation', as: :new_select_reservation

  get "check_reservations/", to: "reservation_approval#index", as: :check_reservations
  get "check_group_reservations/", to: "reservation_group_approval#index", as: :check_group_reservations

  post "reservation_groups/:reservation_group_id/approve", to: "reservation_group_approval#approve", as: :reservation_group_approve
  post "check_group_reservations/:reservation_group_id/reject", to: "reservation_group_approval#reject", as: :reservation_group_reject
  post "check_group_reservations/:reservation_group_id/suspend", to: "reservation_group_approval#suspend", as: :reservation_group_suspend
  post "reservation_groups/:reservation_group_id/cancel", to: "reservation_group_approval#cancel", as: :reservation_group_cancel

  post "reservation_groups/:reservation_group_id/confirm", to: "reservation_groups#confirm", as: :reservation_group_confirm

  get "reservations_group/:reservation_group_id/reject" => 'reservation_group_approval#justify_status', as: :justify_reject_group
  get "reservations_group/:reservation_group_id/suspend" => 'reservation_group_approval#justify_status', as: :justify_suspend_group

  get "suggestions_spreadsheet/import" => 'importer#import_suggestions_spreadsheet', as: :import_suggestions_spreadsheet

  get "spreadsheet/import" => 'importer#import_spreadsheet', as: :import_spreadsheet
  post "class_spreadsheet/import" => 'reservation_group_approval#process_class_spreadsheet', as: :process_class_spreadsheet

  post "classes_suggestion_processor/import" => 'classes_suggestion_processor#process_suggestion_spreadsheet', as: :process_suggestion_spreadsheet

  get "classes_suggestions" => 'classes_suggestions#index', as: :classes_suggestions

  post "reservations/:reservation_id/approve", to: "reservation_approval#approve", as: :reservation_approve
  post "check_reservations/:reservation_id/reject", to: "reservation_approval#reject", as: :reservation_reject
  post "check_reservations/:reservation_id/suspend", to: "reservation_approval#suspend", as: :reservation_suspend
  post "reservations/:reservation_id/cancel", to: "reservation_approval#cancel", as: :reservation_cancel

  post "mass_action/approve/", to: "mass_reservation_actions#approve", as: :mass_approve
  post "mass_action/reject/", to: "mass_reservation_actions#reject", as: :mass_reject
  post "mass_action/suspend/", to: "mass_reservation_actions#suspend", as: :mass_suspend
  post "mass_action/cancel/", to: "mass_reservation_actions#cancel", as: :mass_cancel
  post "mass_action/delete/", to: "mass_reservation_actions#delete", as: :mass_delete

  get "reservations/:reservation_id/reject" => 'reservation_approval#justify_status', as: :justify_reject
  get "reservations/:reservation_id/suspend" => 'reservation_approval#justify_status', as: :justify_suspend

  get "mass_action/reject" => 'mass_reservation_actions#justify_mass_status', as: :justify_mass_reject
  get "mass_action/suspend" => 'mass_reservation_actions#justify_mass_status', as: :justify_mass_suspend

  get '/dashboard', to: 'dashboard#dashboard', as: :dashboard

  get '/places/preview/:id', to: 'reservations#preview', as: :place_preview

  get '/places/:id/get_reservations', to: 'places#get_reservations', as: :get_place_reservations

  get '/places/slot_search', to: 'places#slot_search', as: :slot_search

  resources :users, path: 'accounts'
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  get 'reservation_groups/:id/edit_period', to: 'reservation_groups#edit_period', as: :edit_period_reservation_group
  patch 'reservation_groups/:id/update_period', to: 'reservation_groups#update_period', as: :update_period_reservation_group

  get '/vehicles/:id/reservations', to: 'vehicles#get_reservations', as: :get_vehicle_reservations

  post "vehicle_reservations/:id/approve", to: "vehicle_reservation_approval#approve", as: :vehicle_reservation_approve
  get "vehicle_reservations/:id/reject" => 'vehicle_reservation_approval#justify_status', as: :justify_reject_for_vehicle_reservation
  get "vehicle_reservations/:id/suspend" => 'vehicle_reservation_approval#justify_status', as: :justify_suspend_for_vehicle_reservation

  post "vehicle_reservations/:id/reject", to: "vehicle_reservation_approval#reject", as: :vehicle_reservation_reject
  post "vehicle_reservations/:id/suspend", to: "vehicle_reservation_approval#suspend", as: :vehicle_reservation_suspend

end
