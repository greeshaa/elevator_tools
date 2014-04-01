source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bcrypt-ruby', '3.0.1'
#gem 'will_paginate', '3.0.3'
#gem 'will_paginate-bootstrap'
#gem 'faker', '1.0.1'
#gem 'rails-i18n', '~> 3.0.0.pre'
#gem 'execjs'
gem 'therubyracer'
gem 'unicorn'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
	gem 'sqlite3'
	gem 'annotate', '2.5.0'
	gem 'capistrano'
 	gem 'rvm-capistrano'
end

group :development, :test do
	gem 'rspec-rails', '2.11.0'
	gem 'guard-rspec', '1.2.1'
	gem 'guard-spork', '1.2.0'
	gem 'spork', '0.9.2'
	gem 'childprocess', '0.3.6'
end	

group :test do
	#gem 'mysql2'
	gem 'capybara', '1.1.2'
	gem 'rb-fsevent', '0.9.1', :require => false
	gem 'growl', '1.0.3'
	gem 'factory_girl_rails', '4.1.0'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner', '0.7.0'
end

group :production do
	gem 'mysql2'
  #gem 'therubyracer', :platforms => :ruby
end	

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  #gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
  gem 'jquery-modal-rails'
  gem 'jquery-rails'
  gem 'sass-rails', '>= 3.2'
  gem 'less-rails'
  #gem 'libv8', '3.16.14.3'
  gem 'bootstrap-sass', '~> 3.1.1'
  gem 'twitter-bootswatch-rails', '~> 3.1.1'
  gem 'twitter-bootswatch-rails-helpers'
  #gem "select2-rails"
  
  

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  
end



# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
