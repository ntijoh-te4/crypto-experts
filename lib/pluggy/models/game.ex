defmodule Pluggy.Game do
  defstruct(id: nil, name: "", class_id: nil, url: "", w_c: nil)

  alias Pluggy.Game


  def get_student_from_class(2) do
    Postgrex.query!(DB, "SELECT * FROM students WHERE class_id = $1", [2], pool: DBConnection.ConnectionPool).rows
    |> Enum.map(fn x -> Enum.concat(x, ["wrong"]) end)
    |> Enum.shuffle
    |> correct
    |> Enum.shuffle
    |> to_struct_list
  end

  def correct([head|tail]) do
    head =List.replace_at(head, 4, "correct")
    [head | tail]
  end



  def to_struct_list(rows) do
    for [id, name, class_id, url, w_c] <- rows, do: %Game{id: id, name: name, class_id: class_id, url: url, w_c: w_c}
  end
end
