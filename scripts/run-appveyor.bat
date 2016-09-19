@echo off
setlocal

if /I "%PLATFORM%" == "x64" (
    set CMAKE_GEN_SUFFIX= Win64
) else (
    set CMAKE_GEN_SUFFIX=
)

echo.
echo Preparing %CONFIGURATION% build environment for %GENERATOR%%CMAKE_GEN_SUFFIX% ...
cmake "-G%GENERATOR%%CMAKE_GEN_SUFFIX%" -DPLATFORM=%PLATFORM% -DUNICODE=%UNICODE% -H. -Bbuild
if %errorlevel% neq 0 exit /b %errorlevel%

echo.
echo Building ...
cmake --build build --config %CONFIGURATION%
if %errorlevel% neq 0 exit /b %errorlevel%

echo.
echo Copying generated files ...
copy /y build\example\DllLoader\%CONFIGURATION%\DllLoader.exe build\example\DllLoader\ > NUL
copy /y build\example\DllLoader\%CONFIGURATION%\DllLoaderLoader.exe build\example\DllLoader\ > NUL
copy /y build\example\SampleDLL\%CONFIGURATION%\SampleDLL.dll build\example\SampleDLL\ > NUL

cd build\example\DllLoader

echo.
echo Running DllLoader.exe ...
DllLoader.exe
if %errorlevel% neq 0 exit /b %errorlevel%

echo.
echo Running DllLoaderLoader.exe ...
DllLoaderLoader.exe
if %errorlevel% neq 0 exit /b %errorlevel%