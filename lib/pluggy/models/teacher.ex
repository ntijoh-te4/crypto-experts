defmodule Pluggy.Teacher do
  defstruct(id: nil, name: "", schools: [])

  alias Pluggy.Teacher

  #FIXA VÅR SKIT

  def all do
    Postgrex.query!(DB, "SELECT * FROM classes", [], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end
  def get_schools_for_teacher(teacher_id) do
    Postgrex.query!(DB, "SELECT school_id FROM teacher_school WHERE teacher_id = $1", [if !is_integer(teacher_id) do String.to_integer(teacher_id) else teacher_id end], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end
  def get_teachers_id_for_school(school_id) do
    Postgrex.query!(DB, "SELECT teacher_id,name,school_id FROM teacher_school JOIN users ON teacher_id = users.id WHERE school_id = $1", [if !is_integer(school_id) do String.to_integer(school_id) else school_id end], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list()
  end
  def get_teachers(teacher_id) do
    Postgrex.query!(DB, "SELECT id,name FROM users WHERE id = $1", [if !is_integer(teacher_id) do String.to_integer(teacher_id) else teacher_id end], pool: DBConnection.ConnectionPool).rows
    |> to_struct_list
  end

  def to_struct([[id, name, schools]]) do
    %Teacher{id: id, name: name, schools: schools}
  end

  def teacher_list(rows) do
    for [id] <- rows, do: %Teacher{id: id, name: "", schools: []}
  end
  def to_struct_list(rows) do
    for [id, name, schools] <- rows, do:  %Teacher{id: id, name: name, schools: schools}
  end
end
