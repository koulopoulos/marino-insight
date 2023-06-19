from MarinoDB import MarinoDB
from datetime import datetime
import pandas as pd

class MarinoInsight:
    db=None

    def __init__(self):
        username, password = 'root', '1f9055068a!' # self.__login()
        self.db = MarinoDB(username, password)

    def __login(self):
        print("\nPlease enter your database login credentials.")
        username = input('Enter your username: ')
        password = input('Enter your password: ')
        return username, password
    
    def __unknown_error(self):
        print('An unknown error occurred. Please try again.')
        return -1

    def __unknown_command_error(self):
        print('Unknown command. Please try again.')
        return -1
    
    def __missing_params_error(self):
        print('Missing parameters. Please try again.')
        return -1
    
    def __invalid_params_error(self):
        print('Invalid parameter(s). Please try again.')
        return -1
    
    def __print_table(self, table, modifier=None):
        df = pd.DataFrame(table)
        if modifier:
            modifier(df)
        print('--------------------------------------\n')
        print(df.to_string(index=False) if not df.empty else 'No data')
        print('\n--------------------------------------')

    def __print_result(self, res):
        if res and 'result' in res:
            print(res['result'])
    
    # ----------------------------- Exit ----------------------------- #
    
    def __exit(self):
        sys.exit()

    # ----------------------------- Help ----------------------------- #

    def __help(self):
        print('\nAvailable commands:')
        print('-----------------------------------------')
        # STUDENT
        print('> student list [FLOOR_LEVEL]')
        print('> student login <ID> <FIRST_NAME> <LAST_NAME>')
        print('> student logout <ID>')
        # EQUIPMENT
        print('> equipment list')
        print('> equipment status <ID> <STATUS>')
        # print('> equipment wait <EQUIPMENT_ID>')
        # print('> equipment add <EQUIPMENT_ID> <LEVEL>')
        # print('> equipment remove <EQUIPMENT_ID>')
        # QUEUE
        # print('> queue enter <EQUIPMENT_ID> <STUDENT_ID>')
        # print('> queue exit <EQUIPMENT_ID> <STUDENT_ID>')
        # RESERVATION
        print('> reservation list')
        print('> reservation new <STATUS> <TYPE> <START_DATE> <START_TIME> <END_DATE> <END_TIME> <ROOM_NUMBER>')
        # LOCK
        # print('> lock list')
        # OTHER
        print('> help')
        print('> exit')
        print('-----------------------------------------\n')

    # ----------------------------- Student ----------------------------- #

    def __student_logout(self, params):
        if not params:
            return self.__missing_params_error()
        try:
            student_id = int(params[0])
            res = self.db.update_student_logout(student_id)
            self.__print_result(res)
            return
        except ValueError:
            return self.__invalid_params_error()

    def __student_login(self, params):
        if not params or len(params) < 3:
           return self.__missing_params_error()
        try:
            student_id = int(params[0])
            student_fname = str(params[1])
            student_lname = str(params[2])
            return self.db.update_student_login(student_fname, student_lname, student_id)
        except ValueError:
            return self.__invalid_params_error()

    def __student_list(self, params):
        if not params:
            students = self.db.get_students()
            self.__print_table(students)
            return
        try:
            floor_level = int(params[0])
            students = self.db.get_total_students(floor_level)
            self.__print_table(students)
            return
        except ValueError:
            return self.__invalid_params_error()

    def __student(self, args):
        action = args[0] if args else None
        params = args[1:] if args and len(args) > 1 else None
        match action:
            case 'list':
                return self.__student_list(params)
            case 'login':
                return self.__student_login(params)
            case 'logout':
                return self.__student_logout(params)
            case _:
                return self.__unknown_command_error()
    
    # ----------------------------- Equipment ----------------------------- #

    def __equipment_list(self):
        equipment = self.db.get_equipment()
        self.__print_table(equipment)
        return

    def __equipment_wait(self, params):
        if not params:
            return self.__missing_params_error()
        try:
            equipment_id = int(params[0])
            return self.db.get_equipment_wait(equipment_id)
        except ValueError:
            return self.__invalid_params_error()

    # def __equipment_status(self, params):
    #     if not params or len(params) < 2:
    #         return self.__missing_params_error()
    #     try:
    #         equipment_id = int(params[0])
    #         status = str(params[1])
    #         self.db.update_equipment_status(equipment_id, status)
    #         self.__print_result({ 'result': '' })
    #         return
    #     except ValueError:
    #         return self.__invalid_params_error()
    #     except:
    #         return self.__unknown_error()
        
    # def __equipment_add(self, params):
    #     if not params or len(params) < 2:
    #         return self.__missing_params_error()
    #     try:
    #         equipment_id = int(params[0])
    #         level = int(params[1])
    #         return self.db.create_equipment(equipment_id, level)
    #     except ValueError:
    #         return self.__invalid_params_error()

    # def __equipment_remove(self, params):
    #     if not params:
    #         return self.__missing_params_error()
    #     try:
    #         equipment_id = int(params[0])
    #         return self.db.delete_equipment(equipment_id)
    #     except ValueError:
    #         return self.__invalid_params_error()

    def __equipment(self, args):
        action = args[0] if args else None
        params = args[1:] if args and len(args) > 1 else None
        match action:
            case 'list':
                return self.__equipment_list()
            case 'wait':
                return self.__equipment_wait(params)
            # case 'status':
            #     return self.__equipment_status(params)
            # case 'add':
            #     return self.__equipment_add(params)
            # case 'remove':
            #     return self.__equipment_remove(params)
            case _:
                return self.__unknown_command_error()

    # ----------------------------- Queue ----------------------------- #

    def __queue(self, args):
        pass

    # ----------------------------- Reservation ----------------------------- #

    def __reservation_list(self):
        reservations = self.db.get_reservations()
        self.__print_table(reservations)
        return
    
    def __reservation_status(self, params):
        if not params:
            return self.__missing_params_error()
        try:
            reservation_no = int(params[0])
            status = self.db.get_reservation_status(reservation_no)
            self.__print_table(status)
            return
        except ValueError:
            return self.__invalid_params_error()
        except:
            return self.__unknown_error()
        
    def __reservation_new(self, params):
        if not params or len(params) < 8:
            return self.__missing_params_error()
        try:
            status = params[0]
            rtype = params[1]
            start_date = str(params[2])
            start_time = str(params[3])
            end_date = str(params[4])
            end_time = str(params[5])
            room_no = int(params[6])
            student_id = int(params[7])
            # validate date and time
            start_date_parts = [int(i) for i in start_date.split('-')]
            start_time_parts = [int(i) for i in start_time.split(':')]
            end_date_parts = [int(i) for i in end_date.split('-')]
            end_time_parts = [int(i) for i in end_time.split(':')]
            start_datetime = datetime(
                start_date_parts[0], start_date_parts[1], start_date_parts[2],
                start_time_parts[0], start_time_parts[1], start_time_parts[2]  
            )
            end_datetime = datetime(
                end_date_parts[0], end_date_parts[1], end_date_parts[2],
                end_time_parts[0], end_time_parts[1], end_time_parts[2]  
            )
            # no error thrown means format is correct
            res = self.db.create_reservation(
                status, rtype, start_datetime, end_datetime, room_no, student_id
            )
            self.__print_result(res)
            return
        except ValueError:
            return self.__invalid_params_error()
        except:
            return self.__unknown_error()
    
    def __reservation(self, args):
        action = args[0] if args else None
        params = args[1:] if args and len(args) > 1 else None
        match action:
            case 'list':
                return self.__reservation_list()
            case 'new':
                return self.__reservation_new(params)
            case 'status':
                return self.__reservation_status(params)
            case _:
                return self.__unknown_command_error()

    # ----------------------------- Command handling ----------------------------- #
    
    def __execute(self, command):
        if not command:
            return self.__unknown_command_error()
        
        command = command.split(' ')
        target = command[0]
        args = command[1:] if len(command) > 1 else None
        
        match target:
            case 'student':
                return self.__student(args)
            case 'equipment':
                return self.__equipment(args)
            case 'queue':
                return self.__queue(args)
            case 'reservation':
                return self.__reservation(args)
            case 'help':
                return self.__help()
            case 'exit':
                return self.__exit()
            case _:
                return self.__unknown_command_error()

    def run(self):
        print("\n|------ Marino Insight ------|\n")
        print("Welcome to the Marino Recreation Center management system.")
        print("Enter a command, or type 'help' for more info.")
        while True:
            command = input("> ")
            self.__execute(command)


if __name__ == "__main__":
    #try:
        MarinoInsight().run()
    #except:
    #    print('\n|------ Shutting down ------|\n')
