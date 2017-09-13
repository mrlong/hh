;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  永大软件安装包
;  www.yongdasoft.com
;  开发作者:龙仕云  创建时间:2017-9-12
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!define OUTDIR_NAME "."
!define PRODUCT_SUBNAME "行行询价"
!include .\params.nsi ;引用公共参数
!define PRODUCT_DIR_REGKEY "Software\ydsoft\hh\${PRODUCT_NAME}\hh.exe"
!define PRODUCT_UNINST_KEY "Software\ydsoft\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"


; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"

BrandingText /TRIMRIGHT "亿迪安软件安装系统"
; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\hh.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "SimpChinese"

; MUI end ------

Name "${PRODUCT_NAME}"
OutFile "${PRODUCT_NAME}.exe"
InstallDir "$PROGRAMFILES\亿迪安软件\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite on

  ;这个是编译产生的，不能随意改动 作者:龙仕云  
  File ".\Release\*.*"
 


 


  ;快捷方式	
  CreateDirectory "$SMPROGRAMS\亿迪安软件\${PRODUCT_NAME}"
  CreateShortCut  "$SMPROGRAMS\亿迪安软件\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\hh.exe"
  CreateShortCut  "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\hh.exe"

SectionEnd
  

  Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\亿迪安软件\${PRODUCT_NAME}\卸载${PRODUCT_NAME}.lnk" "$INSTDIR\卸载.exe"
  SectionEnd

  Section -Post
  WriteUninstaller "$INSTDIR\卸载.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\hh.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\hh.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从你的计算机移除。"
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "你确实要完全移除 $(^Name) ，其及所有的组件？" IDYES +2
  Abort
FunctionEnd

Section Uninstall
   
  ;以下内容不能随意更改 作者:龙仕云 2010-1-12	 
  Delete "$INSTDIR\卸载.exe"
  Delete "$INSTDIR\*.*"
 

  RMDir "$INSTDIR"

  ;以下文件不能随意更改	
  Delete "$SMPROGRAMS\亿迪安软件\${PRODUCT_NAME}\卸载${PRODUCT_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\亿迪安软件\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
  RMDir "$SMPROGRAMS\亿迪安软件\${PRODUCT_NAME}"



  RMDir "$INSTDIR"


  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
  SectionEnd
