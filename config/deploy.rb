# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "test-app"
set :repo_url, "https://github.com/spa-87/rails-test-app.git"

set :user, "deploy"
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :nginx_use_ssl, true
