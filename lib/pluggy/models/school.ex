defmodule Pluggy.School do
  defstruct(id: nil, name: "")

  alias Pluggy.School

  #FIXA VÅR SKIT

  def all do
    Postgrex.query!(DB, "SELECT * FROM schools", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  def get(id) do
    Postgrex.query!(DB, "SELECT * FROM schools WHERE id = $1 LIMIT 1", [if !is_integer(id) do String.to_integer(id) else id end],
      pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end
  def get_school_from_class(class_id) do
    Postgrex.query!(DB, "SELECT * FROM schools WHERE id = $1 LIMIT 1", [String.to_integer(class_id)],
      pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end


  # def update(id, params) do
  #   name = params["name"]
  #   tastiness = String.to_integer(params["tastiness"])
  #   id = String.to_integer(id)

  #   Postgrex.query!(
  #     DB,
  #     "UPDATE fruits SET name = $1, tastiness = $2 WHERE id = $3",
  #     [name, tastiness, id],
  #     pool: DBConnection.ConnectionPool
  #   )
  # end

  # def create(params) do
  #   name = params["name"]
  #   tastiness = String.to_integer(params["tastiness"])

  #   Postgrex.query!(DB, "INSERT INTO fruits (name, tastiness) VALUES ($1, $2)", [name, tastiness],
  #     pool: DBConnection.ConnectionPool
  #   )
  # end

  def delete(school_id) do
    Postgrex.query!(DB, "DELETE FROM schools WHERE id = $1", [String.to_integer(school_id)],
      pool: DBConnection.ConnectionPool
    )
  end

  def to_struct([[id, name]]) do
    %School{id: id, name: name}
  end

  def to_struct_list(rows) do
    for [id, name] <- rows, do: %School{id: id, name: name}
  end
end
