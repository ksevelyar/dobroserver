#=== REQUIRE ===#
require 'rvm/capistrano'
set :rvm_type,        :system
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")

require 'bundler/capistrano'

#=== SETTINGS ===#
set :application, "dobroserver"
set :deploy_to,   "/data/projects/#{application}"

set :domain, "192.168.0.1"
set :user,   "ksevelyar"

set :rails_env, "production"

server domain, :web, :app, :db, primary: true

set :use_sudo, false
set :keep_releases, 10

set :shared_children, shared_children + %w{public/uploads}

set :scm,                   :git
set :branch,                "master"
set :deploy_via,            :export
set :git_enable_submodules, 1
set :repository,            "/data/git/#{application}.git"
set :local_repository,      "ssh://#{user}@#{domain}/data/git/#{application}.git"

#=== TASKS ===#
before 'deploy:setup', 'rvm:install_ruby'

after 'deploy:update_code', roles: :app do
  run "rm -f #{current_release}/config/database.yml"
  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
  run "sudo chown -R $(whoami):www-data #{deploy_to}"
end

after 'deploy', 'deploy:migrate', 'deploy:cleanup'

namespace :deploy do
  task :restart do
    run "sudo /etc/init.d/unicorn_dobroserver upgrade"
  end
  task :force_restart do
    run "sudo /etc/init.d/unicorn_dobroserver stop"
    run "sudo /etc/init.d/unicorn_dobroserver start"
  end
  task :start do
    run "sudo /etc/init.d/unicorn_dobroserver start"
  end
  task :stop do
    run "sudo /etc/init.d/unicorn_dobroserver stop"
  end
end

task :import_production_db do
  require 'yaml'

  # Export
  production_db  = YAML::load(capture "cat #{current_path}/config/database.yml")['production']

  dump = "#{production_db['database']}.sql"


  # Surpress debug log output to hide the password
  current_logger_level = self.logger.level
  if current_logger_level >= Capistrano::Logger::DEBUG
    logger.debug %(executing "pg_dump")
    self.logger.level = Capistrano::Logger::INFO
  end

  run "PGPASSWORD=#{production_db['password']} && export PGPASSWORD &&
       pg_dump -Fc --compress=9
               --username=#{production_db['username']}
               --host localhost
               --file=#{current_path}/tmp/#{dump}
               #{production_db['database']} ;
       unset PGPASSWORD"

  # Restore logger level
  self.logger.level = current_logger_level

  # Download
  get "#{current_path}/tmp/#{dump}", "tmp/", via: :scp

  # Clean production
  run "rm -f #{current_path}/tmp/#{dump}"


  # Import
  development_db = YAML::load_file('config/database.yml')['development']

  run_locally "pg_restore -Fc \
                          --clean \
                          --host localhost \
                          --dbname=#{development_db['database']} \
                          --username=#{development_db['username']} \
                          tmp/#{dump} ; \
               rm -f tmp/#{dump}"

end

task :import_production_files do
  get "#{current_path}/public/uploads", "public", via: :scp, recursive: true
end
