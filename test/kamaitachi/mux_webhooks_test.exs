defmodule Kamaitachi.MuxWebhooksControllerTest do
  use Kamaitachi.ConnCase
  alias Kamaitachi.Factory

  test "create/2 returns structs" do
    conn = build_conn()

    conn =
      Factory.mux_status(:created)
      |> Factory.build()
      |> mux_path(conn, &1)
      |> post(conn, &1)

    assert http_response(conn, 201) == nil
  end
end
