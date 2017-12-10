server "192.168.1.123",
    user: "deploy",
    roles: [:web, :app, :db],
    ssh_options: {keys: %w(~/.ssh/jetruby-rails-test-app.pem),  port: 10022}
