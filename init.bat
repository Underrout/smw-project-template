:: AddmusicK
set AMK_DL="https://dl.smwcentral.net/24994/AddmusicK_1.0.8.zip"
set AMK_ZIP="AddmusicK_1.0.8.zip"
set AMK_JUNK="readme.html" "src.zip"
set AMK_JUNK_DIR="readme_files"

set AMK_DIR=%WORKING_DIR%Tools\AddmusicK\

powershell Invoke-WebRequest %AMK_DL% -OutFile %AMK_ZIP% >NUL
powershell Expand-Archive %AMK_ZIP% -DestinationPath %AMK_DIR% >NUL
robocopy /e %AMK_DIR%AddmusicK_1.0.8 %AMK_DIR%
rmdir /S /Q %AMK_DIR%AddmusicK_1.0.8
:: Delete junk files
del %WORKING_DIR%%AMK_ZIP%
for %%a in (%AMK_JUNK%) do (del %AMK_DIR%%%a)
for %%a in (%AMK_JUNK_DIR%) do (rmdir /S /Q %AMK_DIR%%%a)

:: Asar
set ASAR_DL="https://dl.smwcentral.net/25953/asar181.zip"
set ASAR_ZIP="asar181.zip"
set ASAR_JUNK="LICENSE" "license-lgpl.txt" "license-gpl.txt" "license-wtfpl.txt" "README.txt"
set ASAR_JUNK_DIR="ext" "dll" "docs"
set ASAR_DIR=%WORKING_DIR%Tools\Asar\

powershell Invoke-WebRequest %ASAR_DL% -OutFile %ASAR_ZIP% >NUL
powershell Expand-Archive %ASAR_ZIP% -DestinationPath %ASAR_DIR% >NUL
:: Delete junk files
del %WORKING_DIR%%ASAR_ZIP%
for %%a in (%ASAR_JUNK%) do (del %ASAR_DIR%%%a)
for %%a in (%ASAR_JUNK_DIR%) do (rmdir /S /Q %ASAR_DIR%%%a)

:: Flips
set FLIPS_JUNK="license.txt" "boring.zip" "src.zip"
set FLIPS_DIR=%WORKING_DIR%Tools\FLIPS\

for %%a in (%FLIPS_JUNK%) do (del %FLIPS_DIR%%%a)

:: GPS
set GPS_DL="https://dl.smwcentral.net/29130/GPS%20v1.4.3.zip"
set GPS_ZIP="GPS%20v1.4.3.zip"
set GPS_JUNK="list.txt" "src.zip" "Changes.txt" "README.txt"
set GPS_DIR=%WORKING_DIR%Tools\GPS\

powershell Invoke-WebRequest %GPS_DL% -OutFile %GPS_ZIP% >NUL
powershell Expand-Archive %GPS_ZIP% -DestinationPath %GPS_DIR% >NUL
:: Delete junk files
del %WORKING_DIR%%GPS_ZIP%
for %%a in (%GPS_JUNK%) do (del %GPS_DIR%%%a)

copy /y NUL %GPS_DIR%list.txt

:: Lunar Magic
set LM_DL="https://dl.smwcentral.net/26916/lm330.zip"
set LM_ZIP="lm330.zip"
set LM_JUNK="readme.txt" "Lunar Magic.chm"
set LM_DIR=%WORKING_DIR%Tools\LunarMagic\

powershell Invoke-WebRequest %LM_DL% -OutFile %LM_ZIP% >NUL
powershell Expand-Archive %LM_ZIP% -DestinationPath %LM_DIR% >NUL
:: Delete junk files
del %WORKING_DIR%%LM_ZIP%
for %%a in (%LM_JUNK%) do (del %LM_DIR%%%a)

:: PIXI
set PIXI_DL="https://dl.smwcentral.net/26026/pixi_v1.32.zip"
set PIXI_ZIP="pixi_v1.32.zip"
set PIXI_JUNK="removedResources.txt" "changelog.txt" "readme.txt"
set PIXI_DIR=%WORKING_DIR%Tools\PIXI\

powershell Invoke-WebRequest %PIXI_DL% -OutFile %PIXI_ZIP% >NUL
powershell Expand-Archive %PIXI_ZIP% -DestinationPath %PIXI_DIR% >NUL
:: Delete junk files
del %WORKING_DIR%%PIXI_ZIP%
for %%a in (%PIXI_JUNK%) do (del %PIXI_DIR%%%a)

copy /y NUL %PIXI_DIR%list.txt

:: UberASM Tool
set UBER_DL="https://dl.smwcentral.net/19982/UberASMTool14.zip"
set UBER_ZIP="UberASMTool14.zip"
set UBER_JUNK="readme.txt" "readme - library.txt"
set UBER_DIR=%WORKING_DIR%Tools\UberASMTool\

powershell Invoke-WebRequest %UBER_DL% -OutFile %UBER_ZIP% >NUL
powershell Expand-Archive %UBER_ZIP% -DestinationPath %UBER_DIR% >NUL
:: Delete junk files
del %WORKING_DIR%%UBER_ZIP%
for %%a in (%UBER_JUNK%) do (del %UBER_DIR%%%a)

del %WORKING_DIR%Tools\HumanReadableMap16\LICENSE
del %WORKING_DIR%Tools\LunarHelper\LICENSE
del %WORKING_DIR%Tools\LunarMagic\LICENSE

copy /y NUL %UBER_DIR%gamemode\_gitkeep
copy /y NUL %UBER_DIR%overworld\_gitkeep
echo ; > %UBER_DIR%library\_gitkeep

start /b "" cmd /c del "%~f0"&exit /b
