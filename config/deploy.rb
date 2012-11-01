require 'bundler/setup'
require 'puma/capistrano'
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

# stub out deploy:restart
namespace :deploy do  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/.rbenv-vars #{release_path}/.rbenv-vars"
  end
end

after 'deploy:finalize_update', 'deploy:symlink_shared'
