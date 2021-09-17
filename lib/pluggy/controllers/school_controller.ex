defmodule Pluggy.SchoolController do
  require IEx

  alias Pluggy.School
  alias Pluggy.User
  alias Pluggy.Class
  alias Pluggy.Students

  import Pluggy.Template, only: [srender: 2]
  import Plug.Conn, only: [send_resp: 3]


  def school(conn, school_id) do
    # get user if logged in
    session_user = conn.private.plug_session["id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end
      school = School.get(school_id)
      classes = Class.all_school_classes(school_id)

    #srender använder slime
    send_resp(conn, 200, srender("admin/school", school: school, classes: classes, user: current_user))
  end

  def index(conn) do
    session_user = conn.private.plug_session["id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

   send_resp(conn, 200, srender("admin/index", schools: School.all(), user: current_user))
  end
  # def index(conn) do
  #   # get user if logged in
  #   session_user = conn.private.plug_session["user_id"]

  #   current_user =
  #     case session_user do
  #       nil -> nil
  #       _ -> User.get(session_user)
  #     end
  #   #srender använder slime
  #   send_resp(conn, 200, srender("admin/index", fruits: Fruit.all(), user: current_user))
  # end



    # TA BORT GÖR OM????

    #fixa?????


    #??????????
    def school_class(conn, class_id_maybe) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

        school = School.get(Class.get(class_id_maybe).school_id)
        classes = Class.get_class_name(class_id_maybe)
        students = Students.students_from_class(class_id_maybe)

      #srender använder slime
      send_resp(conn, 200, srender("admin/class", school: school, classes: classes, students: students, user: current_user))
    end
    #????
    def teacher_index(conn) do
      # get user if logged in
      session_user = conn.private.plug_session["id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

      #srender använder slime
      send_resp(conn, 200, srender("teacher/index", schools: School.all(), user: current_user))
    end
    def teacher_class(conn) do
      # get user if logged in
      session_user = conn.private.plug_session["id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

      #srender använder slime
      send_resp(conn, 200, srender("teacher/class", schools: School.all(), user: current_user))
    end
    def teacher_game_index(conn) do
      # get user if logged in
      session_user = conn.private.plug_session["id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

      #srender använder slime
      send_resp(conn, 200, srender("teacher/game/index", schools: School.all(), user: current_user))
    end
    def teacher_game_correct(conn) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

      #srender använder slime
      send_resp(conn, 200, srender("teacher/game/correct", schools: School.all(), user: current_user))
    end
    def teacher_game_wrong(conn) do
      # get user if logged in
      session_user = conn.private.plug_session["id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

      #srender använder slime
      send_resp(conn, 200, srender("teacher/game/wrong", schools: School.all(), user: current_user))
    end
    defp redirect(conn, url) do
      Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
    end
end
