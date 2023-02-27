defmodule Hyperchats.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Hyperchats.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Hyperchats.PubSub},
      # Start Finch
      {Finch, name: Hyperchats.Finch}
      # Start a worker by calling: Hyperchats.Worker.start_link(arg)
      # {Hyperchats.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Hyperchats.Supervisor)
  end
end
