set :application, "maratona"
set :user, "devinsampa"

set :deploy_to, "/home/devinsampa/rails"

set :repository, "."
set :scm, :none
set :deploy_via, :copy
set :copy_cache,          "/tmp/my-app"
set :copy_compression,    :gzip

# set :scm, 'git'
# set :repository, "ssh://cipriani@www.talleye.com/~/git/maratona.git"
# set :deploy_via, :remote_cache
# set :branch, 'master'
# set :git_shallow_clone, 1
# set :scm_verbose, true

set :use_sudo, false

server "devinsampa", :app, :web, :db, :primary => true
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
      task t, :roles => :app do ; end
    end
end