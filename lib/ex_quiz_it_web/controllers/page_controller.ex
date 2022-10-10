defmodule ExQuizItWeb.PageController do
  @moduledoc false
  use ExQuizItWeb, :controller

  @doc "Main page"
  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
