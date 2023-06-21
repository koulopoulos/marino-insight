# MarinoInsight #

## Setup ##

1. Install and configure Python 3.11.4
2. `pip install` the required dependencies listed in `requirements.txt`
3. Import the provided `marinoinsights.sql` database dump into MySQLWorkbench
4. Ensure the database name is **"marinoinsights"**
5. Run `python MarinoInsights.py`

## User guide ##

1. Enter your MySQL username and password when prompted
2. If a connection to the database is established, the app will render a welcome message to the console
3. type out a command is lowercase (case sensitive) after the `>` prompt and hit the `enter` or `return` key
4. Enter the "help" command for a list of available functions
5. Enter the "exit" command to gracefully shut down the application

## Functionality ##

The application makes the following commands available 
(note <ARG> represents a required argument and [ARG] represents an optional requirement),



`student list [FLOOR_LEVEL]` To get a list of students on a given floor (or all floors if no floor level is provided)

`student login <ID> <FIRST_NAME> <LAST_NAME>` to log a student into the system.

`student logout <ID>` to log a student out of the system.

`equipment list` to get a list of all equipment.

`equipment status <ID> <STATUS>` to update the status of a piece of equipment.

`queue enter <STUDENT_ID> <EQUIPMENT_ID>` to mark a student entering a an equipment queue.

`queue exit <STUDENT_ID>` to mark a student exiting an equipment queue.

`queue list <EQUIPMENT_ID>` to get a list of students in a given equipment's queue.

`reservation list` to get a list of all reservations.

`reservation new <STATUS> <TYPE> <START_DATE> <START_TIME> <END_DATE> <END_TIME> <ROOM_NUMBER>` to create a new reservation in the system.

`help` to get a list of available commands.

`exit` to close the application.
