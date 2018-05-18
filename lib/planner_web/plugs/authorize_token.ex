defmodule PlannerWeb.Plugs.AuthorizeToken do
  import Plug.Conn 

  alias Phoenix.Token

  def init(params), do: params

  def call(conn, _params) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"), 
         {:ok, user_id} <- Token.verify(conn, "authorization", token)
    do
      assign(conn, :user_id, user_id)
    else
      true -> invalid_token(conn)
    end
  end

  def invalid_token(conn) do
    conn
    |> send_resp(401, "Unauthorized")
    |> halt
  end
end
