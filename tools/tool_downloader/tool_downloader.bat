@echo off
setlocal enabledelayedexpansion

REM Set the script's directory as the base path
set "basePath=%~sdp0..\.."

REM Parameters for ExtractAndProcess
set "downloadURL=https://dl.smwcentral.net/35333/"
set "targetFolder=tools\addmusick"
set "itemsToRemove=src.zip Makefile asar.exe addmusicMRemover.pl AM4Batch.exe AMKGUI.exe AMMBatch.exe Visualizations"
set "filesToCopy=tools\tool_downloader\asar\v1.81\32-Bit\asar.dll"
set "extractAll=false"
set "specificFolderToExtract=AddmusicK_1.0.10"

REM Call ExtractAndProcess function
call :ExtractAndProcess

REM Exit with non-zero code if anything went wrong
if %errorlevel% neq 0 (
    echo Something went wrong while attempting to set up '%targetFolder%'
    exit /b %errorlevel%
)

REM Parameters for ExtractAndProcess
set "downloadURL=https://dl.smwcentral.net/31515/"
set "targetFolder=tools\gps"
set "itemsToRemove=Changes.txt src.zip"
set "filesToCopy=tools\tool_downloader\asar\v1.81\32-Bit\asar.dll"
set "extractAll=true"

REM Call ExtractAndProcess function
call :ExtractAndProcess

REM Exit with non-zero code if anything went wrong
if %errorlevel% neq 0 (
    echo Something went wrong while attempting to set up '%targetFolder%'
    exit /b %errorlevel%
)

REM Parameters for ExtractAndProcess
set "downloadURL=https://github.com/Fernap/UberASMTool/releases/download/2.0/UberASMTool20.zip"
set "targetFolder=tools\uberasm_tool"
set "itemsToRemove="
set "filesToCopy=tools\tool_downloader\asar\v1.81\32-Bit\asar.dll"
set "extractAll=true"

REM Call ExtractAndProcess function
call :ExtractAndProcess

REM Exit with non-zero code if anything went wrong
if %errorlevel% neq 0 (
    echo Something went wrong while attempting to set up '%targetFolder%'
    exit /b %errorlevel%
)

REM Parameters for ExtractAndProcess
set "downloadURL=https://dl.smwcentral.net/35121/"
set "targetFolder=tools\lunar_magic"
set "itemsToRemove="
set "filesToCopy="
set "extractAll=true"

REM Call ExtractAndProcess function
call :ExtractAndProcess

REM Exit with non-zero code if anything went wrong
if %errorlevel% neq 0 (
    echo Something went wrong while attempting to set up '%targetFolder%'
    exit /b %errorlevel%
)  

REM Parameters for ExtractAndProcess
set "downloadURL=https://dl.smwcentral.net/32277/"
set "targetFolder=tools\pixi"
set "itemsToRemove=removedResources.txt CONTRIBUTING.html"
set "filesToCopy=tools\tool_downloader\asar\v1.9\64-Bit\asar.dll"
set "extractAll=true"

REM Call ExtractAndProcess function
call :ExtractAndProcess

REM Exit with non-zero code if anything went wrong
if %errorlevel% neq 0 (
    echo Something went wrong while attempting to set up '%targetFolder%'
    exit /b %errorlevel%
) 

if %alreadySetup% neq 1 (
    <nul set /p "= " > ..\pixi\list.txt
)

REM Parameters for ExtractAndProcess
set "downloadURL=https://dl.smwcentral.net/11474/"
set "targetFolder=tools\flips"
set "itemsToRemove=boring.zip flips-linux license.txt src.zip"
set "filesToCopy="
set "extractAll=true"

REM Call ExtractAndProcess function
call :ExtractAndProcess

REM Exit with non-zero code if anything went wrong
if %errorlevel% neq 0 (
    echo Something went wrong while attempting to set up '%targetFolder%'
    exit /b %errorlevel%
)

del /q "%basePath%\tools\tool_downloader\asar\32-Bit\ASAR_LICENSE" > nul 2>&1
del /q "%basePath%\tools\tool_downloader\asar\64-Bit\ASAR_LICENSE" > nul 2>&1
del /q "%basePath%\callisto\ASAR_LICENSE" > nul 2>&1
del /q "%basePath%\callisto\LICENSE" > nul 2>&1

echo.
echo All tools are set up
echo.

REM Ensure required folders for build exist
set "folderList=tools\uberasm_tool\gamemode tools\uberasm_tool\level tools\uberasm_tool\library tools\uberasm_tool\overworld resources\levels tools\uberasm_tool\asm\work tools\addmusick\asm\SNES\bin resources\exgraphics resources\graphics resources\patches resources\modules"

for %%f in (%folderList%) do (
    if not exist "%basePath%\%%f\" (
        echo Creating folder "%%f" ...
        mkdir "%basePath%\%%f"
        if errorlevel 1 (
            echo Failed to create folder "%basePath%\%%f"
        )
    )
)

if "%~1" neq "" (
    (
        echo %basePath%\tools
        echo %basePath%\tools\uberasm_tool
        echo %basePath%\resources
    ) > .dependencies
) else (
    pause
)

goto :eof


:ExtractAndProcess
REM Check if target folder exists and is non-empty
set "alreadySetup=0"
if exist "%basePath%\%targetFolder%\" (
    echo '%targetFolder%' already set up
    set "alreadySetup=1"
    exit /b 0
) else (
    echo '%targetFolder%' does not exist, setting it up from '%downloadURL%'
)
 
REM Download the zip file to the script's directory
echo Downloading '%downloadURL%' ...

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%downloadURL%', '%basePath%\downloaded.zip')"
if %errorlevel% neq 0 (
    echo Download failed
    call :Cleanup
    exit /b %errorlevel%
)

echo Download succeeded

REM Create the target extraction folder inside the base path
if not exist "%basePath%\%targetFolder%" mkdir "%basePath%\%targetFolder%"
if %errorlevel% neq 0 (
    echo Failed to create the target folder
    call :Cleanup
    exit /b %errorlevel%
)

REM Extract either all contents or a specific folder from the zip

echo Extracting ZIP contents to '%targetFolder%' ...
if "%extractAll%"=="true" (
    powershell -Command "Expand-Archive -Path '%basePath%\downloaded.zip' -DestinationPath '%basePath%\%targetFolder%' -Force"
    if %errorlevel% neq 0 (
        echo Extraction failed
        call :Cleanup
        exit /b %errorlevel%
    )
) else (
    powershell -Command "Expand-Archive -Path '%basePath%\downloaded.zip' -DestinationPath '%basePath%\%targetFolder%' -Force"
    if %errorlevel% neq 0 (
        echo Extraction failed
        call :Cleanup
        exit /b %errorlevel%
    )
    robocopy "%basePath%\%targetFolder%\%specificFolderToExtract%" "%basePath%\%targetFolder%" /E /MOVE > nul 2>&1
    if %errorlevel% geq 8 (
        echo Copying failed
        call :Cleanup
        exit /b %errorlevel%
    )
)

echo Extraction succeeded

REM Delete the downloaded zip file
del "%basePath%\downloaded.zip"
if %errorlevel% neq 0 (
    echo Failed to delete the downloaded zip file
    call :Cleanup
    exit /b %errorlevel%
)

REM Remove specified files and folders from the target folder
for %%i in (%itemsToRemove%) do (
    set "itemPath=%basePath%\%targetFolder%\%%i"
    if exist "!itemPath!" (
        if exist "!itemPath!\" (
            rd /s /q "!itemPath!" > nul 2>&1
        ) else (
            del /q "!itemPath!" > nul 2>&1
        )
    )
)
if %errorlevel% neq 0 (
    echo Failed to remove files or folders
    call :Cleanup
    exit /b %errorlevel%
)

REM Copy additional files to the target folder
for %%f in (%filesToCopy%) do (
    copy "%basePath%\%%f" "%basePath%\%targetFolder%\%%~nxf" > nul 2>&1
)
if %errorlevel% neq 0 (
    echo Failed to copy files
    call :Cleanup
    exit /b %errorlevel%
)

echo Successfully set up '%targetFolder%'
exit /b 0

:Cleanup
REM Remove the target folder and its contents
if exist "%basePath%\%targetFolder%" (
    rd /s /q "%basePath%\%targetFolder%" > nul 2>&1
)
