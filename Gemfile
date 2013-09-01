source 'http://rubygems.org'

gem 'rails', :git => 'git://github.com/rails/rails.git', :ref => '5c9f27abaabba0d008cc'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri', '1.4.1'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

gem "devise", :git => "git://github.com/plataformatec/devise.git", :ref => '7dbd2eac2a717'
# gem "gdata"

# Bundle gems for certain environments:
# gem 'rspec', :group => :test
# group :test do
#   gem 'webrat'
# end


# for deployment on Heroku
# gem "heroku"
group :development, :test do
  gem 'sqlite3'
  gem 'taps'
  gem 'heroku'
end
group :production do
  gem 'pg'
  gem 'thin'
end

group :development, :test do
#   gem "rspec-rails", ">= 2.8.1"
  gem 'awesome_print', :require => 'ap'
  gem 'interactive_editor'
end

# group :test do
#   gem "factory_girl", "~> 4.2.0"
# end



group :development do
  gem 'ruby-debug'
#   gem 'awesome_print', :require => 'ap'
#   gem 'interactive_editor'
  gem 'xml-simple', :require => 'xmlsimple'
end

group :test do
  gem "rspec-rails", ">= 2.0.0.beta.8"
  gem 'autotest'
  gem 'autotest-rails'
  gem 'factory_girl'
#   gem 'awesome_print', :require => 'ap'
end
