# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

require 'capistrano/rails'
require 'capistrano/bundler'

require 'capistrano/puma'
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Monit
install_plugin Capistrano::Puma::Nginx

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }


namespace :custom do

    desc "Create required directores"
    task :create_dirs do
        on roles(:app) do
            execute "mkdir -p #{shared_path}/log"
            execute "mkdir -p #{shared_path}/tmp/pids"
            execute "mkdir -p #{shared_path}/tmp/sockets"
        end
    end
    after 'bundler:install', 'custom:create_dirs'

    desc "Symlinks config files"
    task :symlink_config do
        on roles(:app) do
            execute "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
            execute "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
        end
    end
    before 'deploy:migrate', 'custom:symlink_config'

    desc "Restart nginx after config update"
    task :nginx_restart do
        on roles(:app) do
            execute "sudo service nginx restart"
        end
    end
    after 'puma:nginx_config', 'custom:create_dirs'

end

after 'puma:monit:monitor', 'puma:nginx_config'
