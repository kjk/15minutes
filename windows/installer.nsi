!include "MUI.nsh"
SetCompressor /SOLID lzma

!define NLPC         "15minutes"
!define FULL_NAME    "15minutes"
!define EXE_NAME     "15minutes.exe"

InstallDir "$PROGRAMFILES\${FULL_NAME}"
InstallDirRegKey HKCU "Software\${FULL_NAME}" ""

!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Run 15minutes"
!define MUI_FINISHPAGE_RUN_FUNCTION "Run"

!define DESC_DOTNET_DECISION "Microsoft .NET Framework 2.0 or above is required, but it is not installed on your computer. If you continue, setup will download and install Microsoft .NET Framework 2.0 if you have an internet connection.$\n$\nDo you wish to continue installation and download and install Microsoft .NET 2.0? If not, Setup will end and you can manually install the Framework."
; We now install version 2.0.
!define DOTNET_DOWNLOAD_URL "http://download.microsoft.com/download/5/6/7/567758a3-759e-473e-bf8f-52154438565a/dotnetfx.exe"

Function Run
	ExecShell "" "$INSTDIR\${EXE_NAME}" "" SW_SHOWNORMAL
FunctionEnd

; Installer strings
Name "15minutes"
Caption "${FULL_NAME}"

; Name of the installer
OutFile "15minutes-install-${VERSION}.exe"

XPStyle on

; Pages in the installer
!insertmacro MUI_PAGE_WELCOME
;!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Pages in the uninstaller
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE English

Section "Microsoft .Net Framework 2.0" DotNetSection

  SectionIn RO

  ; Test if the .NET framework is already installed.  If it is, then skip the download.
  IfFileExists "$WINDIR\Microsoft.NET\Framework\v2.0.50727\installUtil.exe" lbl_SkipDotNetInstall

  ; Download .NET
  NSISdl::download "${DOTNET_DOWNLOAD_URL}" dotnetfx.exe
  Pop $R0
  
  ; Test whether or not the download succeeded.
  StrCmp $R0 "success" lbl_DotNetDownloadOk
  Abort "Download failed: $R0"
  
  ; Install the downloaded file.
lbl_DotNetDownloadOk:
  Banner::show /NOUNLOAD "Installing Microsoft .NET 2.0"
  nsExec::ExecToStack '"dotnetfx.exe" /q /c:"install.exe /noaspupgrade /q"'
  Pop $R0
  Banner::destroy
  
  StrCmp $R0 "" lbl_DotNetInstallOk
  StrCmp $R0 "0" lbl_DotNetInstallOk

  Abort "Error installing Microsoft .NET 2.0"
  
lbl_DotNetInstallOk:
  SetRebootFlag true  

lbl_SkipDotNetInstall:
SectionEnd

!define REG_UNINSTALL "Software\Microsoft\Windows\CurrentVersion\Uninstall\${FULL_NAME}"

; Install files and registry keys
Section "Install" SecInstall
    SetOutPath "$INSTDIR"
    SetOverwrite on

    File /oname=${EXE_NAME} 15minutes\bin\Release\15minutes.exe

    ; Uninstaller
    WriteRegStr   HKCU "Software\${FULL_NAME}" "" "$INSTDIR"
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    WriteRegStr   HKLM "${REG_UNINSTALL}" "DisplayName" "${FULL_NAME} ${VERSION}"
    WriteRegStr   HKLM "${REG_UNINSTALL}" "DisplayVersion" "${VERSION}"
    WriteRegStr   HKLM "${REG_UNINSTALL}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
    WriteRegDWORD HKLM "${REG_UNINSTALL}" "NoModify" 1
    WriteRegDWORD HKLM "${REG_UNINSTALL}" "NoRepair" 1

    ; Start Menu shortcut
    CreateShortCut "$SMPROGRAMS\15minutes.lnk" "$INSTDIR\${EXE_NAME}" "" "$INSTDIR\${EXE_NAME}" 0

SectionEnd

Section "Uninstall"

    ; Remove registry keys
    DeleteRegKey HKLM "${REG_UNINSTALL}"
    DeleteRegKey HKCU "Software\${FULL_NAME}"

    ; Remove Start Menu shortcut
    Delete "$SMPROGRAMS\15minutes.lnk"

    ; Remove files and uninstaller
    RMDir /r "$INSTDIR"
SectionEnd

UninstallIcon "15minutes\HourGlass.ico"
Icon "15minutes\HourGlass.ico"
