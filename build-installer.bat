@set PATH=%PATH%;%ProgramFiles%\NSIS

@call vc9.bat
@IF ERRORLEVEL 1 goto NO_VC9

@pushd .
@set VERSION=%1
@IF NOT DEFINED VERSION GOTO VERSION_NEEDED

@rem check if makensis exists
@makensis /version >nul
@IF ERRORLEVEL 1 goto NSIS_NEEDED

python checkver.py %VERSION%
@IF ERRORLEVEL 1 goto BAD_VERSION

@rem this assumes they were checked out in proper directories
@pushd 15minutes
devenv 15minutes.sln /Project 15minutes.csproj /ProjectConfig Release /Rebuild
@IF ERRORLEVEL 1 goto BUILD_FAILED
echo Compilation ok!
@popd

@makensis /DVERSION=%VERSION% installer
@IF ERRORLEVEL 1 goto INSTALLER_FAILED

@goto END

:NO_VC9
echo vc9.bat failed
@goto END

:INSTALLER_FAILED
echo Installer script failed
@goto END

:BUILD_FAILED
echo Build failed!
@goto END

:VERSION_NEEDED
echo Need to provide version number e.g. build-release.bat 1.0
@goto END

:NSIS_NEEDED
echo NSIS doesn't seem to be installed. Get it from http://nsis.sourceforge.net/Download
@goto END

:BAD_VERSION
@goto END

:END
@popd

