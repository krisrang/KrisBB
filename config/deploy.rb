require 'bundler/setup'
require "bundler/capistrano"

set :application,     'krisbb'
set :repository,      'git@github.com:krisrang/krisbb.git'
set :domain,          'zeus.kristjanrang.eu'
set :applicationdir,  '/home/deploy/sites/krisbb'
set :user,            'deploy'
set :use_sudo,        false

set :scm, :git
set :branch, "master"

role :web, domain
role :app, domain
role :db, domain, :primary => true

set :deploy_to, applicationdir
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
set :default_environment, {
  'PATH' => "/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:$PATH"
}

after 'deploy:update', 'foreman:export'
after 'deploy:update', 'foreman:restart'

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do
    run "cd #{release_path}; #{sudo} bundle exec foreman export upstart /etc/init " +
        "-f ./Procfile.production -a #{application} -u #{user} -l #{shared_path}/log"
  end

  desc "Start the application services"
  task :start, :roles => :app do
    sudo "start #{application}"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    sudo "stop #{application}"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "#{sudo} start #{application} || #{sudo} restart #{application}"
  end

  desc "Display logs for a certain process - arg example: PROCESS=web-1"
  task :logs, :roles => :app do
    run "cd #{current_path}/log && cat #{ENV["PROCESS"]}.log"
  end
end

namespace :deploy do
  task :restart do
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/.rbenv-vars #{release_path}/.rbenv-vars"
  end
end

after 'deploy:finalize_update', 'deploy:symlink_shared'
