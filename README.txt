Thank you for using the AddressLogger!

The AddressLogger records changes to all the Addresses in a Cheat Engine Cheat
Table and saves them to a CSV file. This extension is particularly useful for
graphing values and understanding how Address values change as you play your
game or run an application. You can choose how frequently you want to log
information, whether it is every 100 milliseconds or 10 minutes. Another option
allows you to observe the addresses as they change.


--- INSTRUCTIONS FOR USE ---

1. Download AddressLogger and extract the contents into the Cheat Engine
autorun directory. You can probably find this at:
"C:\Program Files (x86)\Cheat Engine 6.X.X\autorun\"

2. Restart Cheat Engine if it is already running. Otherwise run it.

3. Make sure your game or application is opened and connected to Cheat Engine
(by clicking the "Select a process to open" icon).

4. Click "Settings" and go down to the "Extra" tab. Here you will find four new
options:

	1 - "Log Changes to Cheat Table Addresses": Activates the AddressLogger.

    2 - "Show Changes On Screen": Select this if you want a form to pop up that
    will display how the values are changing in real time. This effectively
    selects option 1 as well. Using this option will impact performance.

    3 - "Advanced Options": Check to see advanced options. See the docs for
    more details.

    4 - "Logging Interval (ms)": This is how frequently you want to log changes
    to your addresses in milliseconds (real time, not game time). 1000 = 1 sec
    Type in the interval you want and hit "OK".

Note: The script is not capable of running extremely fast intervals like 5ms.
Depending on your hardware and the amount of addresses you are tracking, you may
hit a limit on the fastest speed your computer can handle. Be careful with low
values and don't rely on the timer to give you precise measurements. You can
measure the performance of the script by comparing the "Real Time" column vs the
"Log Time" column in the AddressLogs file (note that if you pause while logging
these times will become misaligned regardless).

6. A dialog box will pop up asking you to pick the Cheat Table you want to
track. Find your Cheat Table and hit "Open".

7. Play your game! You can do your normal work while the AddressLogger is
running, like using the memory scanner or writing injection code. The script
will run completely in the background.

8. Once you are finished, click the "Stop AddressLogger" button that has
appeared next to the "Memory View" button on the main menu. There is also the
option to pause and resume. You can click "Start AddressLogger" to restart
logging without having to load the file again, and select "Change Table" or
"Change Interval" to change the table or interval you want to log. See the
Settings again to change the other options.

9. Go into the autorun directory and then click the AddressLogger directory.
Your logs will be stored in the "logs" directory. They are saved as CSV files.
You can open this file in Excel (which has some nice graphing options) and see a
table of your values, or have some other program work with the CSV files.

Note: If you are writing to a very large log file, be sure to let the program
finish writing to the file before starting the AddressLogger again, or you will
lose any data that was not yet written.

--- END INSTRUCTIONS ---


READ the Docs directory for additional information. 


Author: dexter3
Contact: CE Forum
GitHub: 
Slimer GitHub: https://github.com/d-e-x-t-e-r/slimer
