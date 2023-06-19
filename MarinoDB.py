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
        
    def __commit(self, statement, args=None):
        with self.connection.cursor() as cursor:
            cursor.execute(statement, args)
            return self.connection.commit()

    # ----------------------------- Student ----------------------------- #

    # Log a Student into the facility. (UPDATE)
    def update_student_login(self, student_id: int, lock_no: Optional[int] = None) -> None:
        return self.__fetchall("CALL login_student(%s, %s)", (student_id, lock_no))

    # Log a Student out of the facility. (UPDATE)
    def update_student_logout(self, student_id: int) -> None:
        return self.__fetchall("CALL logout_student(%s)", (student_id))

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

    # Record a Student entering a Queue. (CREATE)
    def update_queue_enter(self, equipment_id: int, student_id: int) -> None:
        pass

    # Record a Student exiting a Queue. (UPDATE)
    def update_queue_exit(self, equipment_id: int, student_id: int) -> None:
        pass

    # Check an Equipment's wait time. (READ)
    def get_equipment_wait(self, equipment_id: int) -> float:
        pass

    # Remove a piece of equipment (DELETE)
    def delete_equipment(self, equipment_id: int) -> None:
        return self.__commit("DELETE FROM equipment WHERE equipment_id=%s", (equipment_id))

    # List all equipment
    def get_equipment(self) -> tuple[dict[str, Any], ...]:
        return self.__fetchall('SELECT * FROM equipment')

    # ----------------------------- Reservation ----------------------------- #

    # Submit a Reservation (CREATE)
    def create_reservation(
        self, student_id: int, room_no: int, type: str, date: str,
        start_time: str, end_time: str, description: Optional[str] = None
    ) -> None:
        pass

    # Check the status of a Reservation (READ)
    def get_reservation_status(self, reservation_number: int) -> str:
        pass

    # Delete a Reservation (DELETE)
    def delete_reservation(self, reservation_number: int) -> None:
        pass

    def get_reservations(self) -> tuple[dict[str, Any], ...]:
        pass
    
    # ----------------------------- Lock ----------------------------- #

    # Add a new Lock to circulation (CREATE)
    def create_lock(self, lock_number: int) -> None:
        pass

    # Remove a Lock from circulation (DELETE)
    def delete_lock(self, lock_number: int) -> None:
        pass

    def get_locks(self) -> tuple[dict[str, Any], ...]:
        pass
