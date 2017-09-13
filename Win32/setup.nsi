;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  ���������װ��
;  www.yongdasoft.com
;  ��������:������  ����ʱ��:2017-9-12
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!define OUTDIR_NAME "."
!define PRODUCT_SUBNAME "����ѯ��"
!include .\params.nsi ;���ù�������
!define PRODUCT_DIR_REGKEY "Software\ydsoft\hh\${PRODUCT_NAME}\hh.exe"
!define PRODUCT_UNINST_KEY "Software\ydsoft\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"


; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"

BrandingText /TRIMRIGHT "�ڵϰ������װϵͳ"
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
InstallDir "$PROGRAMFILES\�ڵϰ����\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite on

  ;����Ǳ�������ģ���������Ķ� ����:������  
  File ".\Release\*.*"
 


 


  ;��ݷ�ʽ	
  CreateDirectory "$SMPROGRAMS\�ڵϰ����\${PRODUCT_NAME}"
  CreateShortCut  "$SMPROGRAMS\�ڵϰ����\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\hh.exe"
  CreateShortCut  "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\hh.exe"

SectionEnd
  

  Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\�ڵϰ����\${PRODUCT_NAME}\ж��${PRODUCT_NAME}.lnk" "$INSTDIR\ж��.exe"
  SectionEnd

  Section -Post
  WriteUninstaller "$INSTDIR\ж��.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\hh.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\hh.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش���ļ�����Ƴ���"
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���估���е������" IDYES +2
  Abort
FunctionEnd

Section Uninstall
   
  ;�������ݲ���������� ����:������ 2010-1-12	 
  Delete "$INSTDIR\ж��.exe"
  Delete "$INSTDIR\*.*"
 

  RMDir "$INSTDIR"

  ;�����ļ������������	
  Delete "$SMPROGRAMS\�ڵϰ����\${PRODUCT_NAME}\ж��${PRODUCT_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$SMPROGRAMS\�ڵϰ����\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
  RMDir "$SMPROGRAMS\�ڵϰ����\${PRODUCT_NAME}"



  RMDir "$INSTDIR"


  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
  SectionEnd
