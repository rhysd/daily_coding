DailyCoding::Application.routes.draw do

  match   '/nologin' => 'top#index'
  match   'profile/:user_id' => 'profile#codes'
  match   'profile/codes/:user_id' => 'profile#codes'
  match   'profile/stared_codes/:user_id' => 'profile#stared_codes'

  post    'fav/create/:answer_id' => 'fav#create'
  delete  'fav/destroy/:answer_id' => 'fav#destroy'

  get     'answers/:problem_id' => 'answers#index'
  get     'answers/:problem_id/:lang' => 'answers#index'
  post    'answers' => 'answers#create'
  delete  'answers' => 'answers#create'
  match   'answers/profile/:uid' => 'answer#profile'
  match   'answers/profile_fav/:uid' => 'answer#profile_fav'

  root :to => 'top#index'

  mount SmartTwitter::Engine => "/", :as => "smart_twitter"


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
