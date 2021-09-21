defmodule Pluggy.School do
  defstruct(school_id: nil, name: "", class_id: nil)

  alias Pluggy.School

  #FIXA VÅR SKIT

  def all do
    Enum.map(Postgrex.query!(DB, "SELECT * FROM schools", [], pool: DBConnection.ConnectionPool).rows, fn x -> x ++ [nil] end)
    |> to_struct_list
  end
  def schools_and_classes do
    Postgrex.query!(DB, "SELECT school_id,classes.name,classes.id FROM classes,schools WHERE school_id = schools.id", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end


  def get(id) do
    Enum.map(Postgrex.query!(DB, "SELECT id,name FROM schools WHERE id = $1 LIMIT 1", [if !is_integer(id) do String.to_integer(id) else id end], pool: DBConnection.ConnectionPool).rows, fn x -> x ++ [nil] end)
    |> to_struct
  end
  def get_school_from_class(class_id) do
    Postgrex.query!(DB, "SELECT school_id,schools.name,classes.id FROM classes JOIN schools ON school_id = schools.id WHERE classes.id = $1", [String.to_integer(class_id)], pool: DBConnection.ConnectionPool).rows
    |> to_struct
  end

  def to_struct([[school_id, name, class_id]]) do
    %School{school_id: school_id, name: name, class_id: class_id}
  end

  def to_struct_list(rows) do
    for [school_id, name, class_id] <- rows, do: %School{school_id: school_id, name: name, class_id: class_id}
  end
end

# id | name  | school_id | id | name
# ----+-------+-----------+----+------
#   1 | 18TEA |         1 |  1 | NTI
#   2 | 18TEB |         1 |  1 | NTI
#   3 | 18TEC |         1 |  1 | NTI
#   4 | 19TEA |         2 |  2 | LBS
#   5 | 19TEB |         2 |  2 | LBS
#   6 | 19TEC |         2 |  2 | LBS
