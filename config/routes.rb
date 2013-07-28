CrownAsia::Application.routes.draw do
  resources :trucks

  resources :generated_certificate_of_qualities do
    get 'search', :on => :collection
    post 'search', :on => :collection
  end

  resources :certificate_of_qualities do
    get 'search', :on => :collection
    post 'search', :on => :collection
  end

  resources :coq_properties

  resources :sales_quotes

  resources :costing_periods

  resources :issued_formula_batches do
    get 'process_batch', :on => :member
    get 'unprocess_batch', :on => :member
  end
  
  resources :issued_formulas do
    post 'update_finished_good', :on => :collection
    post 'update_formula', :on => :collection
    post 'update_item_list', :on => :collection
    post 'show_formula_comment', :on => :collection
    get 'cancel_big_batch', :on => :member
    get 'cancel_small_batch', :on => :member
  end

  resources :formulas do
    post 'update_finished_good', :on => :collection
    post 'update_raw_materials', :on => :collection
  end

  resources :extruders

  resources :mixers

  resources :bags do
    get 'return', :on => :collection
    post 'return', :on => :collection
    post 'update_lot_numbers', :on => :collection
  end
  
  resources :accounts
  
  resources :roles

  resources :finished_good_transactions do
    post 'update_sender', :on => :collection
    post 'update_bags', :on => :collection
    post 'update_issued', :on => :collection
    post 'update_underpack', :on => :collection
  end

  resources :finished_goods do
    get 'transactions', :on => :member
  end

  resources :supply_transactions do
    post 'update_supplies', :on => :collection
  end

  resources :supplies do
    get 'transactions', :on => :member
  end

  resources :raw_material_transactions do
    post 'update_sender', :on => :collection
    post 'update_issued', :on => :collection
  end

  resources :raw_materials do
    get 'transactions', :on => :member
  end

  resources :raw_material_types

  resources :departments

  resources :unit_of_measures

  resources :customers

  resources :suppliers

  devise_for :users, :path_prefix => 'd'
  
  resources :users
  
  match 'permissions' => 'permissions#index'
  
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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
