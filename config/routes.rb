Vvapp::Application.routes.draw do

  get "password_resets/new"
  root 'users#profile'

  # ADMIN Routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # SUBMISSION Routes
  get 'submission', to: 'submissions#show', as: 'submission'
  get 'submission/edit', to: 'submissions#edit', as: 'edit_submission'
  patch 'submission', to: 'submissions#update'
  post 'submission/complete', to: 'submissions#complete', as: 'complete_submission'
  resources :submissions, only: [:new, :create]

  # Submission IMAGES Routes
  get 'submission/images', to: 'submissions#images'
  post 'submission/images', to: 'images#create'
  delete 'submission/images/:id', to: 'images#destroy', as: 'submission_image'

  # SESSION Routes
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"
  get '/logout', to: "sessions#destroy"

  # Password Reset
  resources :password_resets

  # USER Routes
  resources :users, only: [:new, :create]
  get "/register", to: "users#new", as: "register"
  get '/profile', to: "users#profile"
  get '/profile/edit', to: "users#edit_profile", as: "edit_profile"
  patch '/profile', to: 'users#update_profile', as: 'update_profile'

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
