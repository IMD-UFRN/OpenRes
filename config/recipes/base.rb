def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    # Dependencies for Nokogiri RMagick pg Ruby
    run "#{sudo} apt-get -y install python-software-properties imagemagick build-essential git-core subversion curl autoconf zlib1g-dev libssl-dev libreadline6-dev libxml2-dev libyaml-dev libapreq2-dev libmagickwand-dev libxslt1-dev libxml2-dev"
  end
end

namespace :deploy do
  desc "Execute DB Seed"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end

  desc "Symlink uploads folder"
  task :symlink_uploads do
    # run "rm #{current_path}/public/uploads"
    run "ln -s #{shared_path}/uploads #{current_path}/public/uploads"
  end
  after 'deploy', 'deploy:symlink_uploads'
end
