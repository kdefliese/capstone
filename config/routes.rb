Rails.application.routes.draw do
  root "welcome#index"
  get "/login" => "welcome#login"
  get "/auth/:provider/callback" => "sessions#create", as: :auth
  delete "logout" => "sessions#destroy"

  resources :users
  get "users/:id/stats" => "users#stats", as: :user_stats

  get "foods/all" => "foods#all", as: :all_foods
  get "meals/all" => "meals#all", as: :all_meals
  get "ingredients/all" => "ingredients#all", as: :all_ingredients
  get "entries/last" => "entries#last", as: :last_entry

  get "foods/search" => "foods#factual_search", as: :foods_search
  get "foods/search_specific" => "foods#factual_search_specific_product", as: :foods_search_specific

  resources :days

  resources :entries
  resources :meals
  resources :foods
  resources :ingredients
  resources :symptoms







  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
