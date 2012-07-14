DailyCoding::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/users/sign_in' => 'users/sessions#new', :as => :new_session
    get '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_session
  end

  scope 'users' do
    get     ':user_id'               => 'users#codes', :as => 'user'
    get     '/codes/:user_id'        => 'users#codes', :as => 'users_codes'
    get     '/stared_codes/:user_id' => 'users#stared_codes', :as => 'users_stared_codes'
  end

  get       'problems/today'      => 'problems#today'
  resources 'problems',     :only => [:index, :show]

  scope 'favs' do
    post    ':answer_id' => 'favs#create'
    delete  ':answer_id' => 'favs#destroy'
  end

  scope 'answers' do
    get     '/user/:uid'      => 'answer#user'
    get     '/user_fav/:uid'  => 'answer#user_fav'
  end
  scope 'tmpl/answers' do
    get     ':problem_id'       => 'answers#answers', :as => 'tmpl_answers'
    get     ':problem_id/:lang' => 'answers#answers_by_lang', :as => 'tmpl_answers_by_lang'
  end
  resources 'answers', :only => [:show, :create, :destroy]

  root :to => 'top#index'

end
