# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "doris-hyku"
set :repo_url, "https://github.com/notch8/doris-hyku.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/opt/doris-hyku"

append :linked_files, '.env', 'config/analytics_secret.pem', 'config/analytics.yml'  # for capistrano >= 3.5
set :passenger_restart_command, 'PASSENGER_INSTANCE_REGISTRY_DIR="/var/run" /bin/passenger-config restart-app'
set :passenger_restart_options, -> { "#{deploy_to}/current --ignore-app-not-running --ignore-passenger-not-running" }
set :passenger_restart_with_sudo, true
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "tmp/uploads", "tmp/derivatives", "tmp/network_files"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
after 'deploy:publishing', 'sidekiq:restart'

namespace :sidekiq do
  task :restart do
    on roles(:all) do |host|
      execute :sudo, 'systemctl restart sidekiq'
    end
  end
end
