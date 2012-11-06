require 'bundler/setup'
require 'bundler/capistrano'

set :application,         'krisbb'
set :repository,          'git@github.com:krisrang/krisbb.git'
set :domain,              'meow.kristjanrang.eu'
set :applicationdir,      '/home/deploy/sites/krisbb'
set :user,                'deploy'
set :rbenv,               '/home/deploy/.rbenv/bin/rbenv'
set :god_conf_path,       '/home/deploy/sites/god'
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

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
set :default_environment, {
  'PATH' => "/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:$PATH"
}

namespace :deploy do
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/.env #{release_path}/.rbenv-vars"
    run "ln -nfs #{shared_path}/.env #{release_path}/.env"
  end

  # Stub this out
  task :restart, :roles => :app do
  end
end

namespace :god do
  desc "Reload god config"
  task :reload, :roles => :app do
    run "ln -nfs #{current_path}/config/god.conf #{god_conf_path}/#{application}.conf"
    sudo "#{rbenv} exec god load #{god_conf_path}/#{application}.conf"
  end

  task :restart, :roles => :app do
    sudo "#{rbenv} exec god restart krisbb"
  end
end

namespace :secrets do
  desc "Upload env file"
  task :upload, :roles => :app do
    top.upload(".rbenv-vars", "#{shared_path}/.env")
  end
end

namespace :tail do
  desc "Tail production log files" 
  task :production, :roles => :app do
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      trap("INT") { puts 'Interupted'; exit 0; } 
      puts  # for an extra line break before the host name
      puts "#{data}" 
      break if stream == :err
    end
  end

  desc "Tail god log files" 
  task :god, :roles => :app do
    run "tail -f #{shared_path}/log/god.log" do |channel, stream, data|
      trap("INT") { puts 'Interupted'; exit 0; } 
      puts  # for an extra line break before the host name
      puts "#{data}" 
      break if stream == :err
    end
  end
end

after 'deploy:finalize_update', 'secrets:upload', 'deploy:symlink_shared'
after 'deploy:restart', 'god:reload', 'god:restart'
