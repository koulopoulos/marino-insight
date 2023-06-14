from typing import Optional
import pymysql.cursors

# ============================= Typing ============================= #

Any = object()

# ============================= MarinoDB ============================= #

class MarinoDB:
    DATABASE_HOST        = 'localhost'
    DATABASE_NAME        = 'marinodb'
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

    # ----------------------------- Student ----------------------------- #

    # Create a Student
    def create_student(self, student_id: int, lock_no: Optional[int] = None) -> None:
        pass

    # Log a Student into the facility. (UPDATE)
    def update_student_login(self, student_id: int, lock_no: Optional[int] = None) -> None:
        pass

    # Log a Student out of the facility. (UPDATE)
    def update_student_logout(self, student_id: int) -> None:
        pass

    # Check the total number of Students on a given Floor (READ)
    def get_total_students(self, floor_level: int) -> int:
        pass

    def get_students(self) -> tuple[dict[str, Any], ...]:
        pass

    # ----------------------------- Equipment ----------------------------- #

    # Update the status of a piece of Equipment. (UPDATE)
    def update_equipment_status(self, equipment_id: int, status: str) -> None:
        pass

    # Record a Student entering a Queue. (CREATE)
    def update_queue_enter(self, equipment_id: int, student_id: int) -> None:
        pass

    # Record a Student exiting a Queue. (UPDATE)
    def update_queue_exit(self, equipment_id: int, student_id: int) -> None:
        pass

    # Check the average wait time for a Queue. (READ)
    def get_average_wait(self, equipment_id: int) -> float:
        pass

    # Check an Equipment's wait time. (READ)
    def get_current_wait(self, equipment_id: int) -> float:
        pass

    # Remove a piece of equipment (DELETE)
    def delete_equipment(self, equipment_id: int) -> None:
        pass

    def get_equipment(self) -> tuple[dict[str, Any], ...]:
        pass

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
