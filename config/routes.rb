DailyCoding::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/users/sign_in' => 'users/sessions#new', :as => :new_session
    get '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_session
  end

  get     'users/:user_id'              => 'users#codes', :as => 'user'
  get     'users/codes/:user_id'        => 'users#codes', :as => 'users_codes'
  get     'users/stared_codes/:user_id' => 'users#stared_codes', :as => 'users_stared_codes'

  post    'favs/:answer_id'  => 'favs#create'
  delete  'favs/:answer_id' => 'favs#destroy'

  get     'answers/user/:uid'      => 'answer#user'
  get     'answers/user_fav/:uid'  => 'answer#user_fav'
  scope 'tmpl' do
    get   'answers/:problem_id'       => 'answers#answers', :as => 'tmpl_answers'
    get   'answers/:problem_id/:lang' => 'answers#answers_by_lang', :as => 'tmpl_answers_by_lang'
  end
  resources 'answers', :only => [:show, :create, :destroy]

  get       'problems/today'      => 'problems#today'
  resources 'problems',     :only => [:index, :show]

  root    :to => 'top#index'

end
