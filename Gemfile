source 'https://rubygems.org'

gem 'rails', '>= 3.2.3'

group :test, :development do
  gem 'sqlite3'
  gem 'heroku'
  gem 'rspec-rails'
  gem 'spork'
  gem 'pry-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
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
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'twitter-bootstrap-rails', :git => 'https://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'quiet_assets', :git => 'https://github.com/evrone/quiet_assets.git'
gem 'nokogiri'
gem 'jquery-rails'
gem 'will_paginate'
gem 'devise'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'twitter'

# Deploy with Capistrano
group :deployment do
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'capistrano-ext'
  gem 'capistrano_rsync_with_remote_cache'
end

