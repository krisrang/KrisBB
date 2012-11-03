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
  # Stub this out
  task :restart, :roles => :app do
    run "cd #{current_path} && touch tmp/restart.txt"
  end
end

after 'deploy:finalize_update', 'deploy:symlink_shared'
