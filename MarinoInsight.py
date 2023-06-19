from MarinoDB import MarinoDB
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

    def __unknown_command_error(self):
        print('Unknown command. Please try again.')
        return -1
    
    def __missing_params_error(self):
        print('Missing parameters. Please try again.')
        return -1
    
    def __invalid_params_error(self):
        print('Invalid parameter(s). Please try again.')
        return -1
    
    def __print_table(self, table):
        df = pd.DataFrame(table)
        print('--------------------------------------\n')
        print(df.to_string(index=False) if not df.empty else 'No data')
        print('\n--------------------------------------')
        
    
    # ----------------------------- Exit ----------------------------- #
    
    def __exit(self):
        sys.exit()

    # ----------------------------- Help ----------------------------- #

    def __help(self):
        print('\nAvailable commands:')
        print('-----------------------------------------')
        # STUDENT
        print('> student list')
        print('> student login <STUDENT_ID> [LOCK_NO]')
        print('> student logout <STUDENT_ID>')
        # EQUIPMENT
        print('> equipment list')
        print('> equipment wait <EQUIPMENT_ID>')
        print('> equipment status <EQUIPMENT_ID> <STATUS>')
        print('> equipment add <EQUIPMENT_ID> <LEVEL>')
        print('> equipment remove <EQUIPMENT_ID>')
        # QUEUE
        print('> queue enter <EQUIPMENT_ID> <STUDENT_ID>')
        print('> queue exit <EQUIPMENT_ID> <STUDENT_ID>')
        # LOCK
        print('> lock list')
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
            return self.db.update_student_logout(student_id)
        except ValueError:
            return self.__invalid_params_error()

    def __student_login(self, params):
        if not params:
           return self.__missing_params_error()
        try:
            student_id = int(params[0])
            lock_no = int(params[1]) if len(params) > 1 else None
            return self.db.update_student_login(student_id, lock_no)
        except ValueError:
            return self.__invalid_params_error()

    def __student_list(self):
        students = self.db.get_students()
        self.__print_table(students)
        return

    def __student(self, args):
        action = args[0] if args else None
        params = args[1:] if args and len(args) > 1 else None
        match action:
            case 'list':
                return self.__student_list()
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

    def __equipment_status(self, params):
        if not params or len(params) < 2:
            return self.__missing_params_error()
        try:
            equipment_id = int(params[0])
            status = str(params[1])
            return self.db.update_equipment_status(equipment_id, status)
        except ValueError:
            return self.__invalid_params_error()
        
    def __equipment_add(self, params):
        if not params or len(params) < 2:
            return self.__missing_params_error()
        try:
            equipment_id = int(params[0])
            level = int(params[1])
            return self.db.create_equipment(equipment_id, level)
        except ValueError:
            return self.__invalid_params_error()

    def __equipment_remove(self, params):
        if not params:
            return self.__missing_params_error()
        try:
            equipment_id = int(params[0])
            return self.db.delete_equipment(equipment_id)
        except ValueError:
            return self.__invalid_params_error()

    def __equipment(self, args):
        action = args[0] if args else None
        params = args[1:] if args and len(args) > 1 else None
        match action:
            case 'list':
                return self.__equipment_list()
            case 'wait':
                return self.__equipment_wait(params)
            case 'status':
                return self.__equipment_status(params)
            case 'add':
                return self.__equipment_add(params)
            case 'remove':
                return self.__equipment_remove(params)
            case _:
                return self.__unknown_command_error()

    # ----------------------------- Queue ----------------------------- #

    def __queue(self, args):
        pass

    # ----------------------------- Reservation ----------------------------- #

    def __reservation(self, args):
        pass

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
