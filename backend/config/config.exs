use Mix.Config

config :backend, Backend.Repo,
  database: "backend_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

config :backend, Backend.Repo,
  database: "aeon_db",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :backend, ecto_repos: [Backend.Repo]
