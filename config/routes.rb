Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, skip: [:registrations], controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # as :user do
  #   get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  #   put 'users' => 'devise/registrations#update', :as => 'user_registration'
  # end

  devise_scope :user do
    get 'cabinet' => 'users/registrations#show'
    get 'cabinet/edit' => 'users/registrations#edit'
    put 'cabinet' => 'users/registrations#update'
  end

  resources :groups
  resources 'nodes'
  resources 'messages'
  resources 'vk_groups'
  resources 'groups'
  resources :mass_mailings do
    member do
      get :retry
    end
  end

  resources :mass_mailing_nodes, controller: 'mass_mailing_nodes'
  resources :statistics, controller: 'statistics'

  root 'nodes#index'
  resources :node_vks, controller: 'nodes', type: 'Node::Vk'
  resources :node_emails, controller: 'nodes', type: 'Node::Email'


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
