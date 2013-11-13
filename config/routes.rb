# -*- encoding : utf-8 -*-
Booksh::Application.routes.draw do

  devise_for :users
  resources :users  do
    member do
      get :friends
      delete :unfriend
      delete :decline_friendship
      post :accept_friendship
      delete :recall_friendship
      put :request_friendship
    end
    collection do
      get :search
      get :auth
    end
  end
  resources :book_specimens
  resources :books do
    collection do
      get :search
    end
  end

  resources :friendships do
    member do
      delete :destroy
    end
  end

  resources :authors do
    collection do
      get :search
    end
  end

  root to: 'users#showme'
  get '/books/:book_id/create_specimen', to: 'book_specimens#create', as: 'create_specimen_of_book'
  get '/friends', to: 'users#friends'
  get '/friends/search', to:'users#search_friends'
  get '/auth', to: 'users#auth'
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
