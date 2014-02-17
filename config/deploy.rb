# -*- encoding : utf-8 -*-
require 'bundler/capistrano'

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only" 

# load "config/recipes/nodejs"
load 'config/recipes/base'
load 'config/recipes/check'
load 'config/recipes/nginx'
load 'config/recipes/postgresql'
load 'config/recipes/rbenv'
load 'config/recipes/unicorn'

server 'safira-app.com.br', :web, :app, :db, primary: true

ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/id_rsa"]
default_run_options[:shell] = '/bin/bash --login'

set :user, 'deployer'
set :application, 'imdrecursos'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, 'git'

set :repository, 'git@github.com:IMD-UFRN/OpenRes.git'
set :remote, 'origin'
set :branch, 'master'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy', 'deploy:cleanup' # keep only the last 5 releases

load 'deploy/assets'
namespace :assets do
    desc "compile assets locally and upload before finalize_update"
    task :deploy do
        %x[bundle exec rake assets:clean && bundle exec rake assets:precompile]
        ENV['COMMAND'] = " mkdir '#{release_path}/public/assets'"
        invoke
        upload '/path/to/app/public/assets', "#{release_path}/public/assets", {:recursive => true}
    end
end
after "deploy:finalize_update", "assets:deploy"
# postgres db pass ELnGJfiKUBPe88jPvAfgM
