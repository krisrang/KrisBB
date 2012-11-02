require 'bundler/setup'
require 'bundler/capistrano'

set :application,         'krisbb'
set :repository,          'git@github.com:krisrang/krisbb.git'
set :domain,              'zeus.kristjanrang.eu'
set :applicationdir,      '/home/deploy/sites/krisbb'
set :user,                'deploy'
set :port,                3000
set :env,                 'production'

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

namespace :puma do
  desc "Start puma"
  task :start, roles: :app do
    run "cd #{current_path} && bundle exec puma -d -e #{env} -p #{port} -S #{shared_path}/sockets/puma.state --control 'unix://#{shared_path}/sockets/pumactl.sock'", pty: false
  end

  desc "Stop puma"
  task :stop, roles: :app do
    run "cd #{current_path} && bundle exec pumactl -S #{shared_path}/sockets/puma.state stop"
  end

  desc "Restart puma"
  task :restart, roles: :app do
    run "cd #{current_path} && bundle exec pumactl -S #{shared_path}/sockets/puma.state restart"
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
after "deploy:stop", "puma:stop"
after "deploy:start", "puma:start"
after "deploy:restart", "puma:restart"
