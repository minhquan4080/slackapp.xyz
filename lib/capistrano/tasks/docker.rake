namespace :docker do

  desc "docker-compose build"
  task :build do
    on roles(:app) do
      execute "cd #{current_path} && docker-compose build"
    end
  end

  desc "docker-compose up -d"
  task :up do
    on roles(:web) do
      execute "cd #{current_path} && docker-compose up -d"
    end
  end

  desc "docker-compose stop"
  task :stop do
    on roles(:web) do
      execute "cd #{current_path} && docker-compose stop"
    end
  end

  desc "Review running containners"
  task :review do
    on roles(:app) do
      execute "cd #{current_path} docker ps"
    end
  end

  desc "Setup Database"
  task :setup_db do
    on roles(:app) do
      execute "cd #{current_path} && docker-compose run app rake db:create db:migrate db:seed"
    end
  end

  desc "Reset Database"
  task :reset_db do
    on roles(:app) do
      execute "cd #{current_path} && docker-compose run app rake db:drop db:create db:migrate db:seed"
    end
  end

  desc "Rebuild containners"
  task :rebuild do
    on roles(:app) do
      execute "cd #{current_path} && docker-compose stop && docker-compose rm --force && docker-compose build"
    end
  end

  # Danger
  desc "Destroy all containners"
  task :destroy do
    on roles(:app) do
      execute "docker stop $(docker ps -a -q)"
      execute "docker rm $(docker ps -a -q)"
    end
  end

end