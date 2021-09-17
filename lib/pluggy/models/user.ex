defmodule Pluggy.User do
  defstruct(user_id: nil, username: "", pwd: "")

  alias Pluggy.User

  def get(id) do
    Postgrex.query!(DB, "SELECT id, name, pwd FROM users WHERE id = $1 LIMIT 1", [id],
      pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end

  def get_user(username) do
    Postgrex.query!(DB, "SELECT id, name, pwd FROM users WHERE name = $1 LIMIT 1", [username],
        pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end

  def to_struct([]) do
    %User{user_id: nil, username: "", pwd: ""}
  end

  def to_struct([[id, username, pwd]]) do
    %User{user_id: id, username: username, pwd: pwd}
  end


 end
