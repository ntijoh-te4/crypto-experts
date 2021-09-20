defmodule Pluggy.Teacher do
  defstruct(id: nil, name: "", schools: [])

  alias Pluggy.Teacher

  #FIXA VÅR SKIT

  def all do
    Postgrex.query!(DB, "SELECT * FROM classes", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end
  def get_schools(teacher_id) do
    Postgrex.query!(DB, "SELECT school_id FROM teacher_school WHERE teacher_id = $1", [if !is_integer(teacher_id) do String.to_integer(teacher_id) else teacher_id end], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  def to_struct([[id, name, schools]]) do
    %Teacher{id: id, name: name, schools: schools}
  end


  def to_struct_list(rows) do
    for [id, name, schools] <- rows, do:  %Teacher{id: id, name: name, schools: schools}
  end
end
