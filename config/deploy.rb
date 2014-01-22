require 'puma/capistrano'
require 'bundler/capistrano'

set :application, "tw_asset_manager"
set :repository,  "git@github.com:TWChennai/assets_manager.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "app"
set :deploy_to, "/home/app/apps"
set :use_sudo, false
role :web, "10.10.5.17"                          # Your HTTP server, Apache/etc
role :app, "10.10.5.17"                          # This may be the same as your `Web` server
role :db,  "10.10.5.17", :primary => true # This is where Rails migrations will run
role :db,  "10.10.5.17"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
after "deploy:update", "deploy:migrate"

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
