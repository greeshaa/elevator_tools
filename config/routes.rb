# -*- encoding : utf-8 -*-
ElevatorTools::Application.routes.draw do

  

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :address
  resources :streets
  resources :builds
  resources :porches
  resources :lifts 
  resources :nodes do
      resources :ip_address, shallow: true
  end
  resources :equipment_types
  resources :equipment_lists
  resources :equipment
  resources :equipment_line_items
  resources :equipment_move_buffer
  resources :equipment_movements


  root :to => 'static_pages#main'

  match '/signup',  to: 'users#new',            via: :get
  match '/signin',  to: 'sessions#new',         via: :get
  match '/signout', to: 'sessions#destroy',     via: :delete

  get '/main',   to: 'static_pages#main'
  get '/about',   to: 'static_pages#about'
  get '/handbook',   to: 'static_pages#handbook'
  get '/test',   to: 'static_pages#test'
  get 'lifts_inspections',   to: 'lifts#inspections'
  get 'lifts_list',   to: 'lifts#list'
  get 'lifts_fulliftsdata',   to: 'lifts#fulliftsdata'
  get 'equipment_stats', to: 'equipment#stats'
  get 'equipment_store', to: 'equipment#store'
  get 'equipment_broken', to: 'equipment#broken'
  #get 'equipment_relocation', to: 'equipment#relocation'

  get '/address_list', to: 'address#list'
  get '/add_street',  to: 'streets#new'
  get '/list_street',  to: 'streets#list'
  get '/add_build',  to: 'builds#new'
  get '/add_node',  to: 'nodes#new'
  get '/add_lift', to: 'lifts#new'
  get '/add_e_type', to: 'equipment_types#new'
  get '/add_e_list', to: 'equipment_lists#new'
  get '/add_equipment', to: 'equipment#new'
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
