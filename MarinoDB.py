from typing import Optional
import pymysql.cursors

# ============================= Typing ============================= #

Any = object()

# ============================= MarinoDB ============================= #

class MarinoDB:
    DATABASE_HOST        = 'localhost'
    DATABASE_NAME        = 'marinoinsights'
    DATABASE_CHARSET     = 'utf8mb4'
    DATABASE_CURSORCLASS = pymysql.cursors.DictCursor
    connection           = None

    def __init__(self, user: str, password: str):
        self.connection = self.__connect_db(user, password)

    # ----------------------------- Util ----------------------------- #

    def __connect_db(self, user, password):
        try:
            return pymysql.connect(
                host        = self.DATABASE_HOST, 
                user        = user,
                password    = password,
                db          = self.DATABASE_NAME, 
                charset     = self.DATABASE_CHARSET,
                cursorclass = self.DATABASE_CURSORCLASS
            )
        except Exception as e:
            print(f'Failed to establish database connection - {e}')
            sys.exit()

    def __fetchall(self, statement, args=None):
        with self.connection.cursor() as cursor:
            cursor.execute(statement, args)
            return cursor.fetchall()
        
    def __fetchone(self, statement, args=None):
        with self.connection.cursor() as cursor:
            cursor.execute(statement, args)
            return cursor.fetchone()
        
    def __commit(self, statement, args=None):
        with self.connection.cursor() as cursor:
            cursor.execute(statement, args)
            res = cursor.fetchone()
            self.connection.commit()
            return res

    # ----------------------------- Student ----------------------------- #

    # Log a Student into the facility. (UPDATE)
    def update_student_login(self, student_fname: str, student_lname: str, student_id: int) -> None:
        return self.__fetchone("CALL student_login(%s, %s, %s)", (student_fname, student_lname, student_id))

    # Log a Student out of the facility. (UPDATE)
    def update_student_logout(self, student_id: int) -> None:
        return self.__fetchone("CALL student_logout(%s)", (student_id))

    # Check the total number of Students on a given Floor (READ)
    def get_total_students(self, floor_level: int) -> int:
        return self.__fetchall("CALL students_on_floor(%s)", (floor_level))

    # List all students (READ)
    def get_students(self) -> tuple[dict[str, Any], ...]:
        return self.__fetchall('SELECT * FROM student')

    # ----------------------------- Equipment ----------------------------- #

    # Add a new piece of equipment (CREATE)
    def create_equipment(self, equipment_id: int, level: int) -> None:
        return self.__commit(
            "INSERT IGNORE INTO equipment (equipment_id, level) VALUES (%s, %s)", 
            (equipment_id, level)
        )

    # Update the status of a piece of Equipment. (UPDATE)
    def update_equipment_status(self, equipment_id: int, status: str) -> None:
        return self.__commit(
            'UPDATE equipment SET status=%s WHERE equipment_id=%s', 
            (status, equipment_id)
        )

    # Remove a piece of equipment (DELETE)
    def delete_equipment(self, equipment_id: int) -> None:
        return self.__commit("DELETE FROM equipment WHERE equipment_id=%s", (equipment_id))

    # List all equipment
    def get_equipment(self) -> tuple[dict[str, Any], ...]:
        return self.__fetchall('SELECT * FROM equipment')
    
    # ----------------------------- Queue ----------------------------- #

    # Record a Student entering a Queue. (CREATE)
    def update_queue_enter(self, student_id: int, equipment_id: int) -> None:
        return self.__commit("CALL queue_enter(%s, %s)", (student_id, equipment_id))

    # Record a Student exiting a Queue. (DELETE)
    def update_queue_exit(self, student_id: int) -> None:
        return self.__commit("DELETE FROM queue WHERE student_id=%s", (student_id))

    # List a Queue. (READ)
    def get_queue(self, equipment_id: int) -> int:
        return self.__fetchall(
            """SELECT student_id, entry_datetime 
                FROM queue WHERE equipment_id=%s 
                ORDER BY entry_datetime ASC""", 
            (equipment_id)
        )

    # ----------------------------- Reservation ----------------------------- #

    # Submit a Reservation (CREATE)
    def create_reservation(
        self, status: str, type: str, start_datetime: str, 
        end_datetime: str, room_no: int, student_id: int,
    ) -> None:
        return self.__fetchone(
            "CALL create_reservation(%s, %s, %s, %s, %s, %s)", 
            (status, type, start_datetime, end_datetime, room_no, student_id)
        )

    # Check the status of a Reservation (READ)
    def get_reservation_status(self, reservation_number: int) -> str:
        return self.__fetchall("CALL reservation_status(%s)", (reservation_number))

    def get_reservations(self) -> tuple[dict[str, Any], ...]:
        return self.__fetchall("CALL get_reservations()")
    
    # ----------------------------- Lock ----------------------------- #

    # Add a new Lock to circulation (CREATE)
    def create_lock(self, lock_number: int) -> None:
        pass

    # Remove a Lock from circulation (DELETE)
    def delete_lock(self, lock_number: int) -> None:
        pass

    def get_locks(self) -> tuple[dict[str, Any], ...]:
        pass
