source 'https://rubygems.org'

gem 'rails', '3.2.13'
ruby '2.0.0'

# Gems used only for assets and not required
# in production environments by default.

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'pry-remote'
  gem 'spork'
  gem 'simplecov'
  gem 'debugger'
end

group :development do
  #rails g bootstrap:themedなどのscaffoldを使うとき便利なコマンドを使いたいので、読み込んでます。
  #rails g bootstrap:installするとレイアウトが壊れてしまうのでやらないこと。
  gem 'therubyracer', :platforms => :ruby
  gem 'less-rails'
  gem 'twitter-bootstrap-rails'
end

group :production do
  gem 'pg'
  gem 'newrelic_rpm'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails', :git => 'git://github.com/anjlab/bootstrap-rails.git'
  gem 'compass-rails'
  gem 'jquery-rails'
  gem 'sassy-buttons'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-ui-rails'
gem 'sorcery'

gem 'simple_form'
gem 'cocoon'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'
gem 'foreman'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# suck this beta ver.
#gem 'debugger2'
