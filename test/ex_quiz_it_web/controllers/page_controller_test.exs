defmodule ExQuizItWeb.PageControllerTest do
  use ExQuizItWeb.ConnCase

  test "get /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
