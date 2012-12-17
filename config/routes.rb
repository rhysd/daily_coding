DailyCoding::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  devise_scope :user do
    get '/users/sign_in' => 'users/sessions#new', :as => :new_session
    get '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_session
  end

  scope 'users' do
    get     ':user_id'               => 'users#codes', :as => 'user'
    get     '/codes/:user_id'        => 'users#codes', :as => 'users_codes'
    get     '/stared_codes/:user_id' => 'users#stared_codes', :as => 'users_stared_codes'
  end

  scope 'problems' do
    get     '/today' => 'problems#today', :as => 'problems_today'
    get     ':id/answers/:lang' => 'problems#show'
  end
  resources 'problems',  :only => [:index, :show]

  scope 'favs' do
    post    '/create/:answer_id' => 'favs#create', :as => 'fav_create'
    post    '/destroy/:answer_id' => 'favs#destroy', :as => 'fav_destroy'
  end

  scope 'answers' do
    get     '/user/:uid'      => 'answer#user'
    get     '/user_fav/:uid'  => 'answer#user_fav'
  end
  resources 'answers', :only => [:show, :create, :destroy]

  root :to => 'top#index'

end
