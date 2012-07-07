DailyCoding::Application.routes.draw do

  get     'profiles/:user_id'              => 'profiles#codes', :as => 'profile'
  get     'profiles/codes/:user_id'        => 'profiles#codes', :as => 'profiles_codes'
  get     'profiles/stared_codes/:user_id' => 'profiles#stared_codes', :as => 'profiles_stared_codes'

  post    'fav/create/:answer_id'  => 'fav#create'
  delete  'fav/destroy/:answer_id' => 'fav#destroy'

  get     'answers/profile/:uid'      => 'answer#profile'
  get     'answers/profile_fav/:uid'  => 'answer#profile_fav'
  scope 'tmpl' do
    get   'answers/:problem_id'       => 'answers#answers', :as => 'tmpl_answers'
    get   'answers/:problem_id/:lang' => 'answers#answers_by_lang', :as => 'tmpl_answers_by_lang'
  end
  resources 'answers', :only => [:show, :create, :destroy]

  get       'problems/today'      => 'problems#today'
  resources 'problems',     :only => [:index, :show]

  root    :to => 'top#index'

  mount SmartTwitter::Engine => "/", :as => "smart_twitter"

end
