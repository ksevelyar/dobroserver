# frozen_string_literal: true

# App
set :application, 'dobroserver'
set :deploy_to,   "/code/#{fetch :application}"
set :rails_env, 'production'

set :linked_files, %w[config/database.yml config/settings/production.yml newrelic.yml]
set :linked_dirs, %w[log tmp/pids tmp/sockets vendor/bundle public/uploads]

# Git
set :branch, 'master'
set :repo_url, 'git@github.com:ksevelyar/dobroserver.git'

# SSH
set :ssh_options,
    user: 'ksevelyar',
    forward_agent: true

# Capistrano
set :format, :pretty
set :log_level, :info
set :keep_releases, 7

# Tasks
namespace :deploy do
  after :finishing, 'deploy:cleanup'
  after 'deploy:publishing', 'deploy:restart'

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
      sleep 3
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
end
