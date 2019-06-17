# frozen_string_literal: true

namespace :setup do
  desc 'Setup configs and database'
  task :development do
    puts 'Copy configs...'
    Rake::Task['setup:copy_configs'].invoke
    puts

    puts 'Setup databases...'
    Rake::Task['db:test:prepare'].invoke
    puts

    puts 'Demo records...'
    Rake::Task['db:seed'].invoke
  end

  task :copy_configs do
    config_dir = File.expand_path('../../config', File.dirname(__FILE__))

    FileUtils.cp "#{config_dir}/database.yml.example", "#{config_dir}/database.yml"
  end
end
