defmodule EDA.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # {EDA, ["hello?"]},
      {EDA.Service, ["boo"]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EDA.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
