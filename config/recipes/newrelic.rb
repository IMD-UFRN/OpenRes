# New Relic Account License
set_default :newrelic_key, 'ed151cdd5690c9a384ba021081b0f8442188264d'

namespace :newrelic do
  desc 'Install New Relic'
  task :install do
    template 'newrelic.list', '/tmp/newrelic.list'
    run "#{sudo} cp /tmp/newrelic.list /etc/apt/sources.list.d/newrelic.list"
    run "wget -O- http://download.newrelic.com/548C16BF.gpg | #{sudo} apt-key add -"
    run "#{sudo} apt-get update && #{sudo} apt-get install -y newrelic-sysmond"
  end
  after 'deploy:install', 'newrelic:install'

  desc 'Setup New Relic configuration for this application'
  task :setup do
    run "#{sudo} nrsysmond-config --set license_key=#{newrelic_key}"
    restart
  end
  after 'deploy:setup', 'newrelic:setup'

  %w[start stop restart].each do |command|
    desc "#{command.capitalize} newrelic-sysmond"
    task command do
      run "#{sudo} service newrelic-sysmond #{command}"
    end
  end
end

