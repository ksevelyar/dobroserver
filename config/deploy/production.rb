set :stage, :production

set :rvm_type, :system

server 'dobroserver.ru', user: 'ksevelyar', roles: %w{web app db}

namespace :deploy do
  after :publishing, "deploy:sitemap:refresh"
end
