@ECHO off
SET VERSION="latest"
SET COMMAND="node -v"
SET PORTS="3001:3001"

:loop
IF NOT "%~1"=="" (
  IF NOT "%~2"=="" ( 
    IF "%~1"=="-c" (
      SET COMMAND=%2
      SHIFT
    )
    IF "%~1"=="-v" (
      SET VERSION=%2
      SHIFT
    ) 
    IF "%~1"=="-p" (
      SET PORTS=%2
      SHIFT
    ) 
  )
	SHIFT
  GOTO :loop
)

rem echo -c %COMMAND% -v %VERSION% -p %PORTS%
sh nodejs.sh -c %COMMAND% -v %VERSION% -p %PORTS%
