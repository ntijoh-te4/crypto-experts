defmodule Pluggy.SchoolController do
  require IEx

  alias Pluggy.School
  alias Pluggy.User
  alias Pluggy.Class
  alias Pluggy.Students
  alias Pluggy.Teacher
  alias Pluggy.Game

  import Pluggy.Template, only: [srender: 2]
  import Plug.Conn, only: [send_resp: 3]


  def school(conn, school_id) do
    # get user if logged in
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end
      school = School.get(school_id)
      classes = Class.all_school_classes(school_id)
      teachers = Teacher.get_teachers_id_for_school(school_id)

      # Enum.map(teachers, fn x -> Teacher.get_teachers(x.id).name end)

      # teachers = Teacher.get_teachers(teachers_id.teacher_id)

      if session_user != 1 do
        send_resp(conn, 200, srender("login", user: current_user))
    end

    #srender använder slime
    send_resp(conn, 200, srender("admin/school", school: school, teachers: teachers, classes: classes, user: current_user))
  end

  def index(conn) do
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

      if session_user != 1 do
        send_resp(conn, 200, srender("login", user: current_user))
    end

   send_resp(conn, 200, srender("admin/index", schools: School.all(), user: current_user))
  end

    def school_class(conn, class_id_maybe) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]


      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end


        # tack till Linus Sjunnesson, 2021-09-17. Jävligt snygg lösning! <3
        school = School.get(Class.get(class_id_maybe).school_id)
        classes = Class.get_class_name(class_id_maybe)
        students = Students.get_students_from_class(class_id_maybe)

        if session_user != 1 do
          send_resp(conn, 200, srender("login", user: current_user))
      end

      #srender använder slime
      send_resp(conn, 200, srender("admin/class", school: school, classes: classes, students: students, user: current_user))
    end
    #????
    def teacher_index(conn) do
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

        schools = School.all()
        classes = School.schools_and_classes()



     send_resp(conn, 200, srender("teacher/index", schools: schools, classes: classes, user: current_user))
    end

    @spec teacher_class(any, any) :: none
    def teacher_class(conn, class_id) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

      school = School.get_school_from_class(class_id)
      class = Class.get_class_name(class_id)
      students = Students.get_students_from_class(class_id)

      #srender använder slime
      send_resp(conn, 200, srender("teacher/class", school: school, class: class, students: students, user: current_user))
    end
    def teacher_game_index(conn, class_id) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

        students = Game.get_student_from_class(class_id)
        class = Class.get_class_name(class_id)

      #srender använder slime
      send_resp(conn, 200, srender("teacher/game/index", students: students, class: class, user: current_user, class_id: class_id))
    end
    def teacher_game_correct(conn, class_id) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

        class = Class.get_class_name(class_id)

      #srender använder slime
      send_resp(conn, 200, srender("teacher/game/correct", schools: School.all(), class: class, user: current_user, class_id: class_id))
    end
    def teacher_game_wrong(conn, class_id) do
      # get user if logged in
      session_user = conn.private.plug_session["user_id"]

      current_user =
        case session_user do
          nil -> nil
          _ -> User.get(session_user)
        end

        class = Class.get_class_name(class_id)

      #srender använder slime
      send_resp(conn, 200, srender("teacher/game/wrong", schools: School.all(), class: class, user: current_user, class_id: class_id))
    end
    defp redirect(conn, url) do
      Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
    end



#DEletar inte bra för db, funkar ej
def delete_school(conn, school_id) do
  session_user = conn.private.plug_session["user_id"]


    current_user =
      case session_user do
        nil -> nil
        _ -> User.get(session_user)
      end

    if session_user != 1 do
        send_resp(conn, 200, srender("login", user: current_user))
      end

    School.delete(school_id)

    send_resp(conn, 200, srender("admin/index", schools: School.all(), user: current_user))
  end
end
