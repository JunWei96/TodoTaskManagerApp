source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
gem 'bootstrap-sass', '>= 3.3.7'
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'
gem 'faker',          '>= 1.7.3'
gem 'will_paginate',           '>=3.1.6'
gem 'bootstrap-will_paginate', '>=1.0.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'wdm' , '>= 0.1.0' if Gem.win_platform?
gem 'jquery-rails', '>= 4.3.1'
gem 'bootstrap-datepicker-rails', '~> 1.7', '>= 1.7.1.1'
gem 'acts-as-taggable-on', '~> 5.0'
gem 'font-awesome-sass'
gem 'whenever', require: false

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rails-controller-testing', '>= 1.0.2'
  gem 'minitest-reporters',       '>= 1.1.14'
  gem 'guard',                    '>= 2.13.0'
  gem 'guard-minitest',           '>= 2.4.4'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
