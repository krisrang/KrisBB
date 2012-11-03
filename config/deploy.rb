require 'bundler/setup'
require 'bundler/capistrano'

set :application,         'krisbb'
set :repository,          'git@github.com:krisrang/krisbb.git'
set :domain,              'zeus.kristjanrang.eu'
set :applicationdir,      '/home/deploy/sites/krisbb'
set :user,                'deploy'

set :scm, :git
set :branch, "master"

role :web, domain
role :app, domain
role :db, domain, primary: true

set :deploy_to, applicationdir
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :bundle_flags, "--deployment --binstubs --shebang ruby-local-exec"
set :default_environment, {
  'PATH' => "/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:$PATH"
}

namespace :deploy do
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/.rbenv-vars #{release_path}/.rbenv-vars"
  end
end

set :shared_children, shared_children << 'tmp/sockets'

namespace :deploy do
  # desc "Start the application"
  # task :start, :roles => :app, :except => { :no_release => true } do
  #   run "cd #{current_path} && bundle exec puma -e production -p 3000 -S #{shared_path}/sockets/puma.state --control 'unix://#{shared_path}/sockets/pumactl.sock' >> #{shared_path}/log/puma.log 2>&1 &", :pty => false
  # end

  # Stub this out
  task :restart, :roles => :app do
  end
end

after 'deploy:finalize_update', 'deploy:symlink_shared'
