@echo off
cls
title Test Suite - STO
CD /d "%~dp0"
echo "Running test suite - STO Server test"
:: This will get system info, if you want. Just remember to delete the Host Name, and the Product ID.
:start
	ECHO.
		set choice=
		set /p choice=Do you want to get system info? (y/n)
		if not '%choice%'=='' set choice=%choice:~0,1%
		if '%choice%'=='y' goto Syteminfo
		if '%choice%'=='n' goto Skip
		ECHO "%choice%" is not valid, try again
		ECHO.
	goto start
	:Syteminfo
	echo Getting System Info..........
	systeminfo > systeminfo.txt
	start notepad systeminfo.txt
	echo Complete
	goto end
	:Skip
	echo Skipping System Info
	goto end
:end
:: This will run the Dxdiag command, if you need it.
:start
	ECHO.
		set choice=
		set /p choice=Do you want to get Dxdiag? (y/n)
		if not '%choice%'=='' set choice=%choice:~0,1%
		if '%choice%'=='y' goto Dxdiag
		if '%choice%'=='n' goto Skip
		ECHO "%choice%" is not valid, try again
		ECHO.
	goto start
	:Dxdiag
	echo Getting Dxdiag..........
	start Dxdiag
	echo Complete
	goto end
	:Skip
	echo Skipping Dxdiag.
	goto end
:end
:: This will flush the DNS cache before testing the connection.
echo Flushing DNS......
@echo off
ipconfig /flushdns
ipconfig /flushdns
ipconfig /flushdns
ipconfig /flushdns
ipconfig /flushdns
echo Completed
:: This will ping test the STO servers, based on your choice. 
echo Perfoming Ping test of the Star Trek Online Servers
Echo Getting Baseline.......
ping google.ca > baseling.txt
start notepad baseline.txt
echo Finished
:start
	ECHO.
		set choice=
		set /p choice=Type the number to run the command. 1 will run a normal ping test (4 times), 2 will run it 8 times, and 3 will run it 50 times.
		if not '%choice%'=='' set choice=%choice:~0,1%
		if '%choice%'=='1' goto Normal Ping Test
		if '%choice%'=='2' goto 8 Times Ping Test
		if '%choice%'=='3' goto 50 Times Ping Test
		ECHO "%choice%" is not valid, try again
		ECHO.
	goto start
	:Normal Ping Test
	ECHO This is a Normal Test, please wait
	ping patchserver.crypticstudios.com > ping_NORMAL.txt
	Start notepad ping_NORMAL.txt
	goto end
	:8 Times Ping Test
	ECHO This will run the test 8 times, please wait
	ping patchserver.crypticstudios.com -n 8 > ping_8Times.txt
	Start notepad ping_8Times.txt
	goto end
	:50 Times Ping Test
	ECHO This will run the test 50 times, please wait
	ping patchserver.crypticstudios.com -n 50 > ping_50Times.txt
	Start notepad ping_50Times.txt
	goto end
:end
echo Completed
:: This will preform a trace route from your connection, to the server. Expect 2 timeouts. They are DNS servers.
echo Trace Route Star Trek Online Servers, this may take some time.
tracert patchserver.crypticstudios.com > Tracert.txt
start notepad Tracert.txt
echo Completed
:: This will open the text files for you to look at the results.
echo All tests have been completed, CMD will now exit.
exit