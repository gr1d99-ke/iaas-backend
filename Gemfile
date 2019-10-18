# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby '2.5.1'

gem 'active_model_serializers', '~> 0.10.0'
gem 'bcrypt'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'faker'
gem 'foreman'
gem 'jwt'
gem 'mock_redis'
gem 'will_paginate'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.2.2'
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'rb-readline'

gem 'shrine'
gem 'valid_email2'

# custom jwt gem
gem 'gr1d99_auth', git: 'https://github.com/gr1d99-ke/gr1d99_auth.git'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'guard-rspec', require: false
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rails-erd'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'shrine-memory'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
