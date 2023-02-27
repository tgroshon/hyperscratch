defmodule Hyperchats.Repo do
  use Ecto.Repo,
    otp_app: :hyperchats,
    adapter: Ecto.Adapters.Postgres
end
