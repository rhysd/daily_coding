source 'https://rubygems.org'

gem 'rails', '>= 3.2.3'

group :test, :development do
  gem 'sqlite3'
  gem 'heroku'
end

group :production do
  # gem 'mysql2'
  gem 'pg'
  gem 'unicorn'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'smart_twitter', :git => 'https://github.com/y-uuki/smart-twitter.git'
gem 'twitter-bootstrap-rails', :git => 'https://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'quiet_assets', :git => 'https://github.com/evrone/quiet_assets.git'
gem 'nokogiri'
gem 'jquery-rails'
gem "rspec-rails", :group => [:development, :test]
gem 'ruby-debug19', :require => 'ruby-debug'
gem 'pry', :group => :development

# Deploy with Capistrano
group :deployment do
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'capistrano-ext'
  gem 'capistrano_rsync_with_remote_cache'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

