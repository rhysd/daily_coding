DailyCoding::Application.routes.draw do

  get     'profiles/:user_id'              => 'profiles#codes'
  get     'profiles/codes/:user_id'        => 'profiles#codes'
  get     'profiles/stared_codes/:user_id' => 'profiles#stared_codes'

  post    'fav/create/:answer_id'  => 'fav#create'
  delete  'fav/destroy/:answer_id' => 'fav#destroy'

  get     'answers/:problem_id'       => 'answers#index', :as => 'answers_problem'
  get     'answers/:problem_id/:lang' => 'answers#index', :as => 'answers_problem_lang'
  post    'answers'                   => 'answers#create'
  delete  'answers'                   => 'answers#delete'
  get     'answers/profile/:uid'      => 'answer#profile'
  get     'answers/profile_fav/:uid'  => 'answer#profile_fav'

  get       'problems/today' => 'problems#today'
  resources 'problems', :only => [:index, :show]

  root    :to => 'top#index'

  mount SmartTwitter::Engine => "/", :as => "smart_twitter"

end
