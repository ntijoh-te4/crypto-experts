defmodule Pluggy.SchoolController do
  require IEx

  alias Pluggy.School
  import Pluggy.Template, only: [srender: 2]
  import Plug.Conn, only: [send_resp: 3]


  def school(conn, id) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

    #srender använder slime
    send_resp(conn, 200, srender("admin/school", school: School.get(id), user: current_user))
  end

  def index(conn) do
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end



   send_resp(conn, 200, srender("admin/index", schools: School.all(), user: current_user))
  end






end
