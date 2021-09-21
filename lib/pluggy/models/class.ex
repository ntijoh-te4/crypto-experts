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

  def get_class_name(class_id) do
    Postgrex.query!(DB, "SELECT * FROM classes WHERE id = $1 LIMIT 1", [String.to_integer(class_id)],
      pool: DBConnection.ConnectionPool
    ).rows
    |> to_struct
  end
  def get_school_from_class(class_id) do
    Postgrex.query!(DB, "SELECT * FROM classes WHERE id = $1 LIMIT 1", [String.to_integer(class_id)],
      pool: DBConnection.ConnectionPool
    ).rows
    |> IO.inspect()
    |> to_struct
  end

  def to_struct([[id, name, school_id]]) do
    %Class{id: id, name: name, school_id: school_id}
  end

  def to_struct_list(rows) do
    for [id, name, school_id] <- rows, do:  %Class{id: id, name: name, school_id: school_id}
  end
end
