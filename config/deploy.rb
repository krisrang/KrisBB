require 'bundler/setup'
require 'bundler/capistrano'
require 'meow-deploy'

set :application,         'krisbb'
set :repository,          'git@github.com:krisrang/krisbb.git'
set :domain,              'meow.kristjanrang.eu'
set :applicationdir,      '/home/deploy/sites/krisbb'
set :user,                'deploy'
set :use_sudo,            false

set :scm, :git
set :branch, "master"

role :web, domain
role :app, domain
role :db, domain, primary: true

set :deploy_to, applicationdir
set :deploy_via, :remote_cache

set :shared_children, shared_children + %w{public/avatars}

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:port] = 24365

set :default_environment, {
  'PATH' => 
  "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH"
}

after 'deploy:create_symlink', 'secrets:upload', 'secrets:symlink'
after 'deploy:restart', 'god:reload', 'god:restart'
