source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers', '~> 0.10.0'
gem 'coffee-rails', '~> 4.2'
gem 'figaro'
gem 'jbuilder', '~> 2.5'
gem 'pg', '~> 0.21'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'random_words'
gem 'redis', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate'

# added in production to populate test events, this should never be in production in a real project
gem 'factory_bot'
gem 'factory_bot_rails'
gem 'faker'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'pry'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'simplecov'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
