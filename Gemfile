source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'bcrypt', '~> 3.1.7'
gem 'paramore'
gem 'interactor-initializer'
gem 'jwt'
gem 'ibandit'
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'database_cleaner-active_record'
  gem 'rspec-json_expectations'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
