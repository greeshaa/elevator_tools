# -*- encoding : utf-8 -*-
ElevatorTools::Application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :address
  resources :streets
  resources :builds
  resources :porches
  resources :lifts do
    collection { put :move }
  end
  resources :inspections
  resources :overhauls
  resources :nodes
  resources :equipment_types
  resources :equipment_lists
  resources :equipment
  resources :equipment_line_items
  resources :equipment_move_buffer
  resources :equipment_movements
  resources :providers
  resources :mechanics do
    resources :lifts
  end
  resources :foremen
  resources :contracts
  resources :partners
  resources :prices
  resources :downtimes
  resources :connections do
      resources :ip_address, shallow: true
  end


  root :to => 'static_pages#main'

  match '/signup',  to: 'users#new',            via: :get
  match '/signin',  to: 'sessions#new',         via: :get
  match '/signout', to: 'sessions#destroy',     via: :delete

  get '/main',   to: 'static_pages#main'
  get '/statistics',   to: 'static_pages#statistics'
  get '/about',   to: 'static_pages#about'
  get '/handbook',   to: 'static_pages#handbook'
  get '/test',   to: 'static_pages#test'
  get 'lifts_inspections',   to: 'lifts#inspections'
  get 'lifts_list',   to: 'lifts#list'
  get 'fulliftsdata',   to: 'lifts#fulliftsdata'
  get 'equipment_stats', to: 'equipment#stats'
  get 'equipment_store', to: 'equipment#store'
  get 'equipment_broken', to: 'equipment#broken'
  get '/nodes_all',  to: 'nodes#all'
  get 'lifts_of_nodes',  to: 'lifts#lifts_of_nodes'
  get 'lifts_of_contract',  to: 'lifts#lifts_of_contract'
  get 'overdue_lifts',  to: 'lifts#overdue_lifts'
  get 'overdue_inspections',  to: 'inspections#overdue'
  get 'next_inspections',  to: 'inspections#next'
  get 'last_inspections',  to: 'inspections#last'
  get 'mechanics/:id/work_order', to: 'mechanics#work_order', :as => :work_order
  get 'mechanics/:id/lift_move', to: 'mechanics#lift_move', :as => :mechanics_lift_move
  get 'nodes/:id/lift_move', to: 'nodes#lift_move', :as => :nodes_lifts_move
  get 'contracts/:id/lift_move', to: 'contracts#lift_move', :as => :contracts_lifts_move
  get 'lifts/:id/select_price', to: 'lifts#select_price', :as => :select_price
  patch 'lifts/:id/select_price_save', to: 'lifts#select_price_save', :as => :select_price_save
  get 'lifts/:id/select_price_cancel', to: 'lifts#select_price_cancel', :as => :select_price_cancel
  get 'lifts/:id/add_downtime', to: 'downtimes#new', :as => :add_downtime
  #get 'equipment_relocation', to: 'equipment#relocation'

  get '/address_list', to: 'address#list'
  get '/district', to: 'address#district'
  get '/add_street',  to: 'streets#new'
  get '/list_street',  to: 'streets#list'
  get '/add_build',  to: 'builds#new'
  get '/add_node',  to: 'nodes#new'
  get '/add_lift', to: 'lifts#new'
  get '/add_e_type', to: 'equipment_types#new'
  get '/add_e_list', to: 'equipment_lists#new'
  get '/add_equipment', to: 'equipment#new'
  get '/new_provider', to: 'providers#new'
  #get 'edit_ip', to: 'nodes#edit_ip', :as => :edit_ip
  #get 'equipment/:id/move_equipment', to: 'equipment_movements#new', :as => :move_equipment

  #get "streets/show"
  #get "streets/index"
  #get "builds/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
