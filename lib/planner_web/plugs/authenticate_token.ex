defmodule PlannerWeb.Plugs.AuthenticateToken do
  import Plug.Conn 

  alias Phoenix.Token

  def init(params), do: params

  def call(%Plug.Conn{params: %{"token" => token}} = conn, _) do
    {status, user_id} = Token.verify(conn, "authorization", token)
    if status == :ok do
      assign(conn, :user_id, user_id)
    else
      invalid_token(conn)
    end
  end

  def call(conn, _), do: invalid_token(conn)

  def invalid_token(conn) do 
    conn
    |> send_resp(401, "Unauthorized")
    |> halt
  end
end
