Rails.application.routes.draw do
  
  resources :regions
  resources :folders
  delete     "folder/:folder_id/link/:link_id", to: "folders#remove_link", as: 'remove_link'

  devise_for :users, :path_prefix => 'd'

  root    "link#index"

  get     "users",                          to: "user#index"

  get     "user",                           to: "user#show"
  delete  "user/:user_name",                to: "user#destroy"
  
  get     "user/:user_name/edit",           to: "user#edit",        as: 'edit_user'
  put     "user",                           to: "user#update"
  
  # put     "user/follow/:link_id",           to: "user#follow",      as: 'user_follow'
  # put     "user/unfollow/:link_id",         to: "user#unfollow",    as: 'user_unfollow'
  
  # get     "user/links/:type",               to: "link#index",       as: 'links'
  # get     "user/links",                     to: "link#index"
  # get     "user/:user_name/links/:type",    to: "link#index"
  
  get     "links",                          to: "link#index",      as: "links"
  get     "links/search",                   to: "link#search",     as: "search_links"
  get     "links/:type/:value",             to: "link#index"
  get     "links/:type/:name/:value",       to: "link#index"

  post    "links/search",                   to: "link#search"


  get     "link/:id",                       to: "link#show",        as: "link"
  get     "link",                           to: "link#new",         as: "new_link"
  post    "link/generate",                  to: "link#generate",    as: "generate"

  get     'link/:id/edit',                  to: "link#edit",        as: "edit_link"
  put     "link",                           to: "link#update"
  post    "link",                           to: "link#create"

  delete  "link/:id",                       to: "link#destroy"

  namespace :api do
    get "link", to:"link#add"
  end

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
