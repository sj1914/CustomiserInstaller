!define PRODUCT_NAME "Customiser"
!define PRODUCT_VERSION "1.0"
!define PY_VERSION "3.6.3"
!define PY_MAJOR_VERSION "3.6"
!define BITNESS "32"
!define ARCH_TAG ""
!define INSTALLER_NAME "Customiser_1.0.exe"
!define PRODUCT_ICON "glossyorb.ico"

; Marker file to tell the uninstaller that it's a user installation
!define USER_INSTALL_MARKER _user_install_marker
 
SetCompressor lzma

!define MULTIUSER_EXECUTIONLEVEL Highest
!define MULTIUSER_INSTALLMODE_DEFAULT_CURRENTUSER
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_COMMANDLINE
!define MULTIUSER_INSTALLMODE_INSTDIR "Customiser"
!include MultiUser.nsh

; Modern UI installer stuff 
!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "glossyorb.ico"
!define MUI_UNICON "glossyorb.ico"

; UI pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MULTIUSER_PAGE_INSTALLMODE
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_LANGUAGE "English"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${INSTALLER_NAME}"
ShowInstDetails show

Section -SETTINGS
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
SectionEnd

Section -Prerequisites
  SetOutPath $INSTDIR\Prerequisites
  IfFileExists $SYSDIR\Miniconda3-latest-Windows-x86_64.exe endMiniconda beginMiniconda
  Goto endMiniconda
  beginMiniconda:
  MessageBox MB_YESNO "For this application Miniconda is needed. Install Miniconda?" /SD IDYES IDNO endMiniconda
  File "../../Prerequisites\Miniconda3-latest-Windows-x86_64.exe"
  ExecWait "$INSTDIR\Prerequisites\Miniconda3-latest-Windows-x86_64.exe /S /InstallationType=JustMe /AddToPath=1 /RegisterPython=0"
  Goto endMiniconda
  endMiniconda:
SectionEnd

Section "!${PRODUCT_NAME}" sec_app
  SetRegView 32
  SectionIn RO
  File ${PRODUCT_ICON}
  SetOutPath "$INSTDIR\pkgs"
  File /r "pkgs\*.*"
  SetOutPath "$INSTDIR"

  ; Marker file for per-user install
  StrCmp $MultiUser.InstallMode CurrentUser 0 +3
    FileOpen $0 "$INSTDIR\${USER_INSTALL_MARKER}" w
    FileClose $0
    SetFileAttributes "$INSTDIR\${USER_INSTALL_MARKER}" HIDDEN

      ; Install files
    SetOutPath "$INSTDIR"
      File "Customiser.launch.pyw"
      File "glossyorb.ico"
      File "gui.py"
      File "image_to_texture.py"
      File "execute_python.bat"
      File "spec-file.txt"
  
  ; Install directories
    SetOutPath "$INSTDIR\Python"
    File /r "Python\*.*"
    SetOutPath "$INSTDIR\lib"
    File /r "lib\*.*"
    SetOutPath "$INSTDIR\App"
    File /r "App\*.*"
    SetOutPath "$INSTDIR\pkls"
    File /r "pkls\*.*"


    ; Install MSVCRT if it's not already on the system
    IfFileExists "$SYSDIR\ucrtbase.dll" skip_msvcrt
    SetOutPath $INSTDIR\Python
    File msvcrt\api-ms-win-core-console-l1-1-0.dll
    File msvcrt\api-ms-win-core-datetime-l1-1-0.dll
    File msvcrt\api-ms-win-core-debug-l1-1-0.dll
    File msvcrt\api-ms-win-core-errorhandling-l1-1-0.dll
    File msvcrt\api-ms-win-core-file-l1-1-0.dll
    File msvcrt\api-ms-win-core-file-l1-2-0.dll
    File msvcrt\api-ms-win-core-file-l2-1-0.dll
    File msvcrt\api-ms-win-core-handle-l1-1-0.dll
    File msvcrt\api-ms-win-core-heap-l1-1-0.dll
    File msvcrt\api-ms-win-core-interlocked-l1-1-0.dll
    File msvcrt\api-ms-win-core-libraryloader-l1-1-0.dll
    File msvcrt\api-ms-win-core-localization-l1-2-0.dll
    File msvcrt\api-ms-win-core-memory-l1-1-0.dll
    File msvcrt\api-ms-win-core-namedpipe-l1-1-0.dll
    File msvcrt\api-ms-win-core-processenvironment-l1-1-0.dll
    File msvcrt\api-ms-win-core-processthreads-l1-1-0.dll
    File msvcrt\api-ms-win-core-processthreads-l1-1-1.dll
    File msvcrt\api-ms-win-core-profile-l1-1-0.dll
    File msvcrt\api-ms-win-core-rtlsupport-l1-1-0.dll
    File msvcrt\api-ms-win-core-string-l1-1-0.dll
    File msvcrt\api-ms-win-core-synch-l1-1-0.dll
    File msvcrt\api-ms-win-core-synch-l1-2-0.dll
    File msvcrt\api-ms-win-core-sysinfo-l1-1-0.dll
    File msvcrt\api-ms-win-core-timezone-l1-1-0.dll
    File msvcrt\api-ms-win-core-util-l1-1-0.dll
    File msvcrt\api-ms-win-crt-conio-l1-1-0.dll
    File msvcrt\api-ms-win-crt-convert-l1-1-0.dll
    File msvcrt\api-ms-win-crt-environment-l1-1-0.dll
    File msvcrt\api-ms-win-crt-filesystem-l1-1-0.dll
    File msvcrt\api-ms-win-crt-heap-l1-1-0.dll
    File msvcrt\api-ms-win-crt-locale-l1-1-0.dll
    File msvcrt\api-ms-win-crt-math-l1-1-0.dll
    File msvcrt\api-ms-win-crt-multibyte-l1-1-0.dll
    File msvcrt\api-ms-win-crt-private-l1-1-0.dll
    File msvcrt\api-ms-win-crt-process-l1-1-0.dll
    File msvcrt\api-ms-win-crt-runtime-l1-1-0.dll
    File msvcrt\api-ms-win-crt-stdio-l1-1-0.dll
    File msvcrt\api-ms-win-crt-string-l1-1-0.dll
    File msvcrt\api-ms-win-crt-time-l1-1-0.dll
    File msvcrt\api-ms-win-crt-utility-l1-1-0.dll
    File msvcrt\ucrtbase.dll
    File msvcrt\x86.zip
    skip_msvcrt:

  
  ; Install shortcuts
  ; The output path becomes the working directory for shortcuts
  SetOutPath "%HOMEDRIVE%\%HOMEPATH%"
    CreateShortCut "$SMPROGRAMS\Customiser.lnk" "$INSTDIR\Python\pythonw.exe" \
      '"$INSTDIR\Customiser.launch.pyw"' "$INSTDIR\glossyorb.ico"
  SetOutPath "$INSTDIR"

  
  ; Byte-compile Python files.
  DetailPrint "Byte-compiling Python modules..."
  nsExec::ExecToLog '"$INSTDIR\Python\python" -m compileall -q "$INSTDIR\pkgs"'
  WriteUninstaller $INSTDIR\uninstall.exe
  ; Add ourselves to Add/remove programs
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "InstallLocation" "$INSTDIR"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "DisplayIcon" "$INSTDIR\${PRODUCT_ICON}"
  WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "NoModify" 1
  WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
                   "NoRepair" 1

  ; Check if we need to reboot
  IfRebootFlag 0 noreboot
    MessageBox MB_YESNO "A reboot is required to finish the installation. Do you wish to reboot now?" \
                /SD IDNO IDNO noreboot
      Reboot
  noreboot:
SectionEnd

Section "Uninstall"
  SetRegView 32
  SetShellVarContext all
  IfFileExists "$INSTDIR\${USER_INSTALL_MARKER}" 0 +3
    SetShellVarContext current
    Delete "$INSTDIR\${USER_INSTALL_MARKER}"

  Delete $INSTDIR\uninstall.exe
  Delete "$INSTDIR\${PRODUCT_ICON}"
  RMDir /r "$INSTDIR\pkgs"

  ; Remove ourselves from %PATH%

  ; Uninstall files
    Delete "$INSTDIR\Customiser.launch.pyw"
    Delete "$INSTDIR\glossyorb.ico"
    Delete "$INSTDIR\gui.py"
    Delete "$INSTDIR\image_to_texture.py"
    Delete "$INSTDIR\execute_python.bat"
    Delete "$INSTDIR\spec-file.txt"
  ; Uninstall directories
    RMDir /r "$INSTDIR\Python"
    RMDir /r "$INSTDIR\lib"
    RMDir /r "$INSTDIR\App"
    RMDir /r "$INSTDIR\pkls"
    RMDir /r "$INSTDIR\User_Image"

  ; Uninstall shortcuts
      Delete "$SMPROGRAMS\Customiser.lnk"
  RMDir $INSTDIR
  DeleteRegKey SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
SectionEnd


; Functions

Function .onMouseOverSection
    ; Find which section the mouse is over, and set the corresponding description.
    FindWindow $R0 "#32770" "" $HWNDPARENT
    GetDlgItem $R0 $R0 1043 ; description item (must be added to the UI)

    StrCmp $0 ${sec_app} "" +2
      SendMessage $R0 ${WM_SETTEXT} 0 "STR:${PRODUCT_NAME}"
    
FunctionEnd

Function .onInit
  !insertmacro MULTIUSER_INIT
FunctionEnd

Function un.onInit
  !insertmacro MULTIUSER_UNINIT
FunctionEnd

