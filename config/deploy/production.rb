server "165.227.140.56",
    user: "deploy",
    roles: [:web, :app, :db],
    ssh_options: {keys: %w(~/.ssh/jetruby-rails-test-app.pem),  port: 10022}
