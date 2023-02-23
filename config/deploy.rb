set :application, "nullify"
set :deploy_to, "/home/abhisek/apps/#{application}"
#set :repository,  "."

default_run_options[:pty] = true
set :scm, :git
set :repository, 'https://abhisek@bitbucket.org/null0x00/null-automation-framework.git'

#set :scm, :none
#set :deploy_via, :copy
#set :copy_exclude, [".git", ".gitignore"]

set :user, "abhisek"
set :use_sudo, false

role :app, "null.community"
role :web, "null.community"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:update_code" do
  run "rm -rf #{release_path}/config/database.yml"
  run "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"

  run "rm -rf #{release_path}/config/mailgun.rb"
  run "ln -s #{shared_path}/config/mailgun.rb #{release_path}/config/mailgun.rb"

  run "rm -rf #{release_path}/config/google_api_key.p12"
  run "ln -s #{shared_path}/config/google_api_key.p12 #{release_path}/config/google_api_key.p12"

  run "rm -rf #{release_path}/config/twitter.rb"
  run "ln -s #{shared_path}/config/twitter.rb #{release_path}/config/twitter.rb"

  run "ln -s #{shared_path}/uploads #{release_path}/public/"
  #run "cd #{release_path} && bundle install"
  #run "cd #{release_path} && bundle exec rake db:migrate"
  #run "cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile"
end

before :deploy do
  #system("bundle exec rake assets:precompile")
end

after :deploy do
  #system("bundle exec rake assets:clean")
end
