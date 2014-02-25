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

before 'deploy:finalize_update', 'deploy:assets:symlink'
after 'deploy:update_code', 'deploy:assets:precompile'

namespace :deploy do
  namespace :assets do

    task :precompile, :roles => :web do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0 || true
        run_locally("rake assets:clean && rake assets:precompile")
        run_locally "cd public && tar -jcf assets.tar.bz2 assets"
        top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
        run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
        run_locally "rm public/assets.tar.bz2"
        run_locally("rake assets:clean")
      else
        logger.info "Skipping asset precompilation because there were no asset changes"
      end
    end

    task :symlink, roles: :web do
      run ("rm -rf #{latest_release}/public/assets &&
            mkdir -p #{latest_release}/public &&
            mkdir -p #{shared_path}/assets &&
            ln -s #{shared_path}/assets #{latest_release}/public/assets")
    end
  end
end

# postgres db pass ELnGJfiKUBPe88jPvAfgM
