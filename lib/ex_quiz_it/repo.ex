defmodule ExQuizIt.Repo do
  use Ecto.Repo,
    otp_app: :ex_quiz_it,
    adapter: Ecto.Adapters.Postgres
end
