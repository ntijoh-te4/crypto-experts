defmodule Pluggy.Class do
  defstruct(id: nil, name: "", school_id: nil)

  alias Pluggy.Class

  #FIXA VÅR SKIT

  def all do
    Postgrex.query!(DB, "SELECT * FROM classes", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  def all_school_classes(id) do
    Postgrex.query!(DB, "SELECT * FROM classes WHERE school_id = $1", [String.to_integer(id)], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  def get(id) do
    Postgrex.query!(DB, "SELECT * FROM classes WHERE id = $1 LIMIT 1", [String.to_integer(id)],
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

  # def delete(id) do
  #   Postgrex.query!(DB, "DELETE FROM fruits WHERE id = $1", [String.to_integer(id)],
  #     pool: DBConnection.ConnectionPool
  #   )
  # end

  def to_struct([[id, name, school_id]]) do
    %Class{id: id, name: name, school_id: school_id}
  end

  def to_struct_list(rows) do
    for [id, name, school_id] <- rows, do:  %Class{id: id, name: name, school_id: school_id}
  end
end
