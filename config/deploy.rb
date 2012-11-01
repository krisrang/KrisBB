require "bundler/capistrano"

set :application,     'krisbb'
set :repository,      'git@github.com:krisrang/krisbb.git'
set :domain,          'zeus.kristjanrang.eu'
set :applicationdir,  'sites/krisbb'
set :user,            'deploy'

set :scm, :git
set :branch, "master"

role :web, domain
role :app, domain
role :db, domain, :primary => true

set :deploy_to, applicationdir
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :default_environment, {
  'PATH' => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}

after 'deploy:update', 'bundle:install'
after 'deploy:update', 'foreman:export'
after 'deploy:update', 'foreman:restart'

# namespace :bundle do
#   desc "Installs the application dependencies"
#   task :install, :roles => :app do
#     run "cd #{current_path} && bundle --deployment --without development test"
#   end
# end

namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do
    run "cd #{release_path} && bundle exec foreman export upstart /etc/init " +
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
    run "sudo start #{application} || sudo restart #{application}"
  end

  desc "Display logs for a certain process - arg example: PROCESS=web-1"
  task :logs, :roles => :app do
    run "cd #{current_path}/log && cat #{ENV["PROCESS"]}.log"
  end
end

# stub out deploy:restart
namespace :deploy do
  task :restart do
  end
end
