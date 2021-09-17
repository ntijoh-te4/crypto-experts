defmodule Pluggy.UserController do
  # import Pluggy.Template, only: [render: 2] #det här exemplet renderar inga templates
  import Pluggy.Template, only: [srender: 2]
  import Plug.Conn, only: [send_resp: 3]

  alias Pluggy.User

  def login(conn) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

      #srender använder slime
      send_resp(conn, 200, srender("login", user: current_user))
    end

  def login(conn, params) do
    username = params["username"]
    password = params["pwd"]

    user = User.get_user(username)

    #fixa felmeddelanden
    if user.user_id do
      if password == user.pwd do
        if user.user_id == 1 do
          Plug.Conn.put_session(conn, :user_id, user.user_id)
          |> redirect("/admin/index") #skicka vidare modifierad conn
        else
          Plug.Conn.put_session(conn, :user_id, user.user_id)
          |> redirect("/teacher/index") #skicka vidare modifierad conn
        end
      else
        redirect(conn, "/error")
      end
    else
      redirect(conn, "/error")
    end


  end

  def logout(conn) do
    Plug.Conn.configure_session(conn, drop: true) #tömmer sessionen
    |> redirect("/login")
  end


  def error(conn) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

    #srender använder slime
    send_resp(conn, 200, srender("error", user: current_user))
  end
  # def create(conn, params) do
  # 	#pseudocode
  # 	# in db table users with password_hash CHAR(60)
  # 	# hashed_password = Bcrypt.hash_pwd_salt(params["password"])
  #  	# Postgrex.query!(DB, "INSERT INTO users (username, password_hash) VALUES ($1, $2)", [params["username"], hashed_password], [pool: DBConnection.ConnectionPool])
  #  	# redirect(conn, "/fruits")
  # end

  defp redirect(conn, url),
    do: Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
end
