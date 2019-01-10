# frozen_string_literal: true

app_path   = '/code/dobroserver'
rails_root = "#{app_path}/current"

pid_file   = "#{rails_root}/tmp/pids/unicorn.pid"
pid          pid_file
old_pid = pid_file + '.oldbin'

socket_file = "#{app_path}/shared/unicorn.sock"
listen socket_file, backlog: 64

stdout_path  "#{rails_root}/log/unicorn.log"
stderr_path  "#{rails_root}/log/unicorn_error.log"

worker_processes 4
timeout 30

# combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
preload_app true

GC.respond_to?(:copy_on_write_friendly=) &&
  (GC.copy_on_write_friendly = true)

before_fork do |server, _worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!

  # zero-downtime
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |_server, _worker|
  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
