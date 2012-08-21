@echo off
md rls
cls

echo Copying *.dll and Truice.exe
xcopy /O /K /R /Y /H /Q /I /C Functionlib.dll rls\Functionlib.dll > NUL
echo ..
xcopy /O /K /R /Y /H /Q /I /C libmysql.dll rls\libmysql.dll > NUL
echo ..
xcopy /O /K /R /Y /H /Q /I /C Truice.exe rls\Truice.exe > NUL
echo .. DONE
echo.
echo.

echo Copying CSV directory
rd /S /Q rls\CSV > NUL
echo ..
xcopy /O /K /R /Y /H /Q /I /C /E CSV rls\CSV > NUL
echo .. DONE
echo.
echo.

echo Copying LANG directory
rd /S /Q rls\LANG > NUL
echo ..
xcopy /O /K /R /Y /H /Q /I /C /E LANG rls\LANG > NUL
echo .. DONE
echo.
echo.

echo Everything should be ready for creating a 7z. Please press any key to start compressing.
pause
cls

echo Trying to locate 7-Zip.. 
FOR /F "tokens=2* delims= " %%A IN ('REG QUERY "HKLM\Software\7-Zip" /v Path') DO SET Pfad=%%B
echo Found: %Pfad%
echo.

echo Getting revision id
FOR /F "tokens=1,* delims=+" %%I IN ('hg id -n') DO SET Rev=%%I
echo Revision id: %Rev%
echo.
pause

echo Starting compression
cd rls
del /F Truice_rev%Rev%.7z
"%Pfad%\7z" a -x!*.7z -y Truice_rev%Rev%.7z 
echo All done!
echo.

echo ====== Truice_rev%Rev%.7z ======
pause
start explorer /root,%CD%