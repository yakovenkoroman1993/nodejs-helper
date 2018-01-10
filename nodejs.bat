@ECHO off
SET VERSION="latest"
SET COMMAND="node -v"

:loop
IF NOT "%~1"=="" (
  IF "%~1"=="-c" (
  	IF NOT "%~2"=="" ( 
  		SET COMMAND=%2
  	)
    SHIFT
  )
	IF "%~1"=="-v" (
		IF NOT "%~2" == "" ( 
    		SET VERSION=%2
    	)
  		SHIFT
	)	
	SHIFT
  GOTO :loop
)

sh nodejs.sh -c %COMMAND% -v %VERSION%
