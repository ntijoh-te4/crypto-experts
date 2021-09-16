defmodule Mix.Tasks.Seed do
  use Mix.Task

  @shortdoc "Resets & seeds the DB."
  def run(_) do
    Mix.Task.run "app.start"
    drop_tables()
    create_tables()
    seed_data()
  end

  defp drop_tables() do
    IO.puts("Dropping tables")
    Postgrex.query!(DB, "DROP TABLE IF EXISTS schools", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS users", [], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "DROP TABLE IF EXISTS classes", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "DROP TABLE IF EXISTS fruits", [], pool: DBConnection.ConnectionPool)
  end

  defp create_tables() do
    IO.puts("Creating tables")
    Postgrex.query!(DB, "Create TABLE schools (id SERIAL, name VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "Create TABLE users (id SERIAL, name VARCHAR(255) NOT NULL, pwd VARCHAR(255) NOT NULL)", [], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "Create TABLE classes (id SERIAL, name VARCHAR(255) NOT NULL, school_id INTEGER)", [], pool: DBConnection.ConnectionPool)

  end

  defp seed_data() do
    IO.puts("Seeding data")
    Postgrex.query!(DB, "INSERT INTO schools(name) VALUES($1) RETURNING id", ["NTI"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO schools(name) VALUES($1) RETURNING id", ["LBS"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO schools(name) VALUES($1) RETURNING id", ["Pederskrivare"], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "INSERT INTO users(name, pwd) VALUES($1, $2)", ["Admin", "admin"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO users(name, pwd) VALUES($1, $2)", ["Ola", "123"], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO users(name, pwd) VALUES($1, $2)", ["Daniel", "123"], pool: DBConnection.ConnectionPool)

    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["18TEA", 1], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["18TEB", 1], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["18TEC", 1], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["19TEA", 2], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["19TEB", 2], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["19TEC", 2], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["20TEA", 3], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["20TEB", 3], pool: DBConnection.ConnectionPool)
    Postgrex.query!(DB, "INSERT INTO classes(name, school_id) VALUES($1, $2)", ["20TEC", 3], pool: DBConnection.ConnectionPool)


  end

end
