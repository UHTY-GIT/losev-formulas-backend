source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.7', '>= 6.1.7.2'
# Use sqlite3 as the database for Active Record
gem 'pg', '~> 1.5', '>= 1.5.3'
# Use Puma as the app server
gem 'puma', '~> 5.0'

# For env file
gem 'dotenv', '~> 2.8', '>= 2.8.1'

# Code documentation
gem 'swagger-docs'
gem 'swagger_ui_engine', github: 'azelenets/swagger_ui_engine'

# redis-server
gem 'redis', '~> 5.0', '>= 5.0.6'
gem 'redis-namespace', '~> 1.11'

# For auth
gem 'jwt', '~> 2.6'
gem 'bcrypt', '~> 3.1', '>= 3.1.19'
gem 'passgen', '~> 1.2'

# Admin panel
gem 'activeadmin'
gem 'active_admin-sortable_tree', '~> 2.1'
gem 'active_admin_datetimepicker'
gem 'activeadmin-select2', github: 'mfairburn/activeadmin-select2'
gem 'activeadmin_reorderable'
gem 'activeadmin_medium_editor', '~> 1.0'
gem 'activeadmin_addons'
gem 'acts_as_list'
gem 'select2-rails'
gem 'devise'
gem 'sass-rails'

# Pagination
gem 'kaminari'

# Serializer
gem 'acts_as_api'

# File processing
gem 'paperclip', '~> 6.1'
gem 'paperclip-meta'
gem 'aws-sdk', '~> 3.1'
gem 'aws-sdk-s3'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# allow, block and throttle requests (to avoid ddos)
gem 'rack-attack'

# Payment system
gem 'stripe', '~> 8.5'
gem 'hashie'
gem 'httpi'

# Image generating
gem 'rmagick'


# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'pry-rails', '~> 0.3.9',require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'shoulda-matchers', '~> 5.3'