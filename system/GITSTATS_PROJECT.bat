@echo off
Setlocal enabledelayedexpansion
::CODER BY xiaoyao9184 1.0
::TIME 2016-10-24
::FILE GITSTATS_PROJECT
::DESC run gitstats 
::




:v

::variable set
%~d0
cd %~dp0
set d=%date:~0,10%
set t=%time:~0,8%
set tip=VCS-GITSTATS
set ver=1.0
set gitstatsPath=%cd%\gitstats
set projectName=
set projectPath=
set reportPath=
set PYTHONPATH=C:\Python27

set tipChoice_gitstats=gitstats not found, clone from github?[Y yes; N no, manually specify the path]?
set tipEcho_gitstatsPath=Enter your gitstats path
set tipSet_gitstatsPath=Enter or drag a directory here:
set tipEcho_projectPath=Enter your git repository path
set tipSet_projectPath=Enter or drag a directory here:
set tipEcho_projectName=Enter your project name
set tipSet_projectName=Enter name here:




:title
title %tip% %ver%

echo %tip%
echo Do not close!!!
echo ...




:check

::variable check
if not exist %gitstatsPath% (
	goto :choice
)
goto :choiceEnd

:choice
set /P c=%tipChoice_gitstats%
if /I "%c%" EQU "Y" goto :clone
if /I "%c%" EQU "y" goto :clone
if /I "%c%" EQU "N" goto :set
if /I "%c%" EQU "n" goto :set
goto :choice

:clone
git clone https://github.com/hoxu/gitstats.git
goto :choiceEnd

:set
echo %tipEcho_gitstatsPath%
set /p gitstatsPath=%tipSet_gitstatsPath%
goto :choiceEnd

:choiceEnd

if "%reportPath%"=="" (
	for %%p in (!gitstatsPath!) do (
		set reportPath=%%~dpp
	)
)

if "%projectPath%"=="" (
	echo %tipEcho_projectPath%
	set /p projectPath=%tipSet_projectPath%
        set makeSure=true
)

if "%projectName%"=="" (
	for %%p in (!projectPath!) do (
		set projectName=%%~np
	)
)




:tip
echo Your gitstats path is: %gitstatsPath%
echo Your project path is: %projectPath%
echo Your project name is: %projectName%
echo Your project report path is: %reportPath%
if "%makeSure%"=="true" pause
echo Running...




:begin

python %gitstatsPath%\gitstats.py %projectPath% %reportPath%




:exit
echo Press any key to exit...

pause
