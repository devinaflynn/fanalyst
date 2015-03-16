Rails.application.routes.draw do
  devise_for :users, controllers: { :registrations => :registrations }
  resources :teams do
    resource :result
  end
  resources :charges

  get 'user/:id' => 'user#index', as: 'user_detail'


  get 'home' => 'pages#home'

  get 'player_news_nba' => 'leaderboard#player_news_nba'
  get 'jobs' => 'leaderboard#jobs'
  get 'pricing' => 'leaderboard#pricing'
   get 'faq' => 'leaderboard#faq'
  get 'leaderboard' => 'leaderboard#index'
  get 'leaderboard/profile/:id' => 'leaderboard#profile', as: 'leaderboard_profile'
  get 'nfl_leaderboard' => 'leaderboard#nfl_leaderboard'
  get 'mlb_leaderboard' => 'leaderboard#mlb_leaderboard'
  get 'soccer_leaderboard' => 'leaderboard#soccer_leaderboard'
  get 'march_madness_leaderboard' => 'leaderboard#march_madness_leaderboard'
  get 'nhl_leaderboard' => 'leaderboard#nhl_leaderboard'

  root 'pages#home'

  namespace :admin do
    resources :users
    resources :constant_values, only: [:edit, :update]
  end


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
