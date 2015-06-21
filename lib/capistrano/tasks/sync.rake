namespace :sync do
  task :db do
    require 'yaml'

    on roles :db do
      production_db  = YAML::load(capture "cat #{current_path}/config/database.yml")['production']
      dump = "#{production_db['database']}.sql"


      execute "PGPASSWORD='#{production_db['password']}' && export PGPASSWORD && \
               pg_dump --format=custom \
                       --compress=9    \
                       --clean         \
                       --no-privileges \
                       --no-owner \
                       --username=#{production_db['username']} \
                       --host localhost \
                       --file=#{current_path}/tmp/#{dump} \
                       #{production_db['database']} ; \
               unset PGPASSWORD"


      download! "#{current_path}/tmp/#{dump}", "tmp/"
      execute "rm -f #{current_path}/tmp/#{dump}"

      development_db = YAML::load_file('config/database.yml')['development']

      system "pg_restore -Fc \
              --clean \
              --username=#{development_db['username']} \
              --host localhost \
              --dbname=#{development_db['database']} \
              tmp/#{dump}"

      system "rm -f tmp/#{dump}"
    end
  end

  task :uploads do
    system "rsync -avz --copy-dirlinks 192.168.0.1:/data/projects/dobroserver/current/public /data/projects/dobroserver/"
  end
end
