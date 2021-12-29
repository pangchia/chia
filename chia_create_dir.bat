@echo off

echo %1 
echo %2

for /L %%i in (%1,1,%2) do mkdir %%i

pause
