require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "crowdfunding-experiment"
set :repository,  "git@github.com:rwash/crowdfunding-experiment.git"
set :deploy_to, "/projects/crowdfunding-experiment"
ssh_options[:forward_agent] = true
set :rvm_type, :system
set :rails_env, :production

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "orithena.cas.msu.edu"                          # Your HTTP server, Apache/etc
role :app, "orithena.cas.msu.edu"                          # This may be the same as your `Web` server
role :db,  "orithena.cas.msu.edu", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

namespace :customs do
  task :symlink_db_yml do
    run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
before 'bundle:install', 'customs:symlink_db_yml'

namespace :customs do
  task :update_assets_permissions do
    run "sudo chown -R jacobbs:crowdfunding #{shared_path}/assets/*"
  end
end

namespace :deploy do
namespace :assets do
  task :update_asset_mtimes do ; end
end
end
before 'deploy:assets:update_asset_mtimes', 'customs:update_assets_permissions'
