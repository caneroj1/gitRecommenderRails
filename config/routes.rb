require 'route_constraints/oauth_constraint'

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Redirect handler for GitHub OAuth
  get 'redirect', to: "redirects#handle", constraints: OAuthConstraint.new
  get 'redirect', to: "redirects#error"

  # Update user info
  put '/update', to: "users#update"

  # Singleton Resource for User Profiles
  get 'profile', to: "profiles#show"

  # Route for computing language breakdowns for users
  get 'users/:github_id/languages', to: "users#languages", defaults: { format: :js }
  # Route to get all of the repositories for a user
  get 'users/:github_id/repositories', to: "users#repositories", defaults: { format: :js }
  # Route for computing language breakdowns for repositories
  get 'repositories/:id/languages', to: "repositories#languages", defaults: { format: :js }

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
