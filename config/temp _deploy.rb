# -*- encoding : utf-8 -*-
require 'rvm/capistrano'
require 'bundler/capistrano'

ssh_options[:forward_agent] = true
set :rvm_ruby_string, '1.9.3-p448@elevator_tools' 



set :application,   "Elevator Tools"
set :repository,    "git@github.com:greeshaa/elevator_tools.git"
set :default_stage, "production"
set :use_sudo, false
set :user, 'rorbot'
set :scm, :git 
set :normalize_asset_timestamps, false
#set :default_run_options, {:pty => true}

set :rails_env, 'production'
set :branch, 'master'
set :deploy_to, "/var/www/rorbot/etools"
server '90.188.88.216', :web, :app, :db, :primary => true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
