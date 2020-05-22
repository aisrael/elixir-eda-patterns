import Config

config :bcrypt_elixir, log_rounds: 14

# Configures Elixir's Logger
elixir_logger_level = System.get_env("ELIXIR_LOGGER_LEVEL", "debug")

level =
  %{
    "1" => :debug,
    "2" => :info,
    "3" => :warn,
    "debug" => :debug,
    "info" => :info,
    "warn" => :warn
  }
  |> Map.get(String.downcase(elixir_logger_level), :debug)

config :logger, :console,
  level: level,
  format: "$time [$level] $levelpad$metadata $message\n",
  metadata: [:pid]
