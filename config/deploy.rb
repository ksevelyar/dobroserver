# App
set :application, "dobroserver"
set :deploy_to,   "/data/projects/#{fetch :application}"
set :rails_env, "production"

set :linked_files, %w{config/database.yml config/config.yml}
set :linked_dirs, %w{log tmp/pids tmp/sockets vendor/bundle public/uploads}


# Git
set :scm, :git
set :branch, "master"
set :deploy_via, :export
set :repo_url, "git@github.com:ksevelyar/dobroserver.git"

# Ssh
set :ssh_options, {
  user: "ksevelyar",
  forward_agent: true
}

# Capistrano
set :format, :pretty
set :log_level, :info
set :keep_releases, 7

# Tasks
namespace :deploy do
  after :finishing, "deploy:cleanup"

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      execute "sudo /etc/init.d/unicorn_#{fetch :application} upgrade"
    end
  end

  desc 'Force restart application'
  task :force_restart do
    on roles(:app) do
      execute "sudo /etc/init.d/unicorn_#{fetch :application} stop"
      execute "sudo /etc/init.d/unicorn_#{fetch :application} start"
    end
  end

  desc 'Start application'
  task :start do
    on roles(:app) do
      execute "sudo /etc/init.d/unicorn_#{fetch :application} start"
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:app) do
      execute "sudo /etc/init.d/unicorn_#{fetch :application} stop"
    end
  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
end
