*** Settings ***
Library     	 SapGuiLibrary
Library     	 Process
Suite Setup      Connect PartLinQ
Suite Teardown   Close PartLinQ

*** Variable ***
${Winium}     			C:\\Automacao_Testes\\SAP\\Winium.Desktop.Driver.exe
${Saplogon}   			C:\\Program Files (x86)\\SAP\\FrontEnd\\SapGui\\saplogon.exe
${Con_Name}   			conection_name
${Username}   			username
${Password}   			password
${Btn_DeleteRow}        wnd[1]/tbar[0]/btn[14]
${Btn_Pack}             wnd[0]/usr/tabsTS_HU_VERP/tabpUE6POS/ssubTAB:SAPLV51G:6010/btn%#AUTOTEXT001
${Menu_Display}         wnd[0]/mbar/menu[0]/menu[3]
${SAP_Title}            /app/con[0]/ses[0]/wnd[0]/titl
${Tab_AllHUs}           wnd[0]/usr/tabsTS_HU_VERP/tabpUE6POS/ssubTAB:SAPLV51G:6010/tblSAPLV51GTC_HU_001
${Tab_AllItems}         wnd[0]/usr/tabsTAXI_TABSTRIP_OVERVIEW/tabpT\\01/ssubSUBSCREEN_BODY:SAPMV50A:1202/tblSAPMV50ATC_LIPS_OVER_INB
${Tab_HeaderAdmin}      wnd[0]/usr/tabsTAXI_TABSTRIP_HEAD/tabpT\\06
${Tab_ItemAdmin}        wnd[0]/usr/tabsTAXI_TABSTRIP_ITEM/tabpT\\09
${Tab_DocsXVendor}      wnd[0]/usr/cntlMEALV_GRID_CONTROL_VL31/shellcont/shell
${Tab_MatBePacked}      wnd[0]/usr/tabsTS_HU_VERP/tabpUE6POS/ssubTAB:SAPLV51G:6010/tblSAPLV51GTC_HU_002
${Txt_DeliveryQtd}      wnd[0]/usr/tabsTAXI_TABSTRIP_OVERVIEW/tabpT\\01/ssubSUBSCREEN_BODY:SAPMV50A:1202/tblSAPMV50ATC_LIPS_OVER_INB/txtLIPSD-G_LFIMG[2,0]
${Txt_DocCategory}      wnd[0]/usr/ctxtSP$00004-LOW
${Txt_ExtID}            wnd[0]/usr/tabsTAXI_TABSTRIP_HEAD/tabpT\\06/ssubSUBSCREEN_BODY:SAPMV50A:2210/txtRV50A-VERUR_LA
${Txt_ExtItem}          wnd[0]/usr/tabsTAXI_TABSTRIP_ITEM/tabpT\\09/ssubSUBSCREEN_BODY:SAPMV50A:3216/txtLIPS-LIFEXPOS
${Txt_HandlingUnit}     wnd[0]/usr/tabsTS_HU_VERP/tabpUE6POS/ssubTAB:SAPLV51G:6010/tblSAPLV51GTC_HU_001/ctxtV51VE-EXIDV[0,0]
${Txt_HU_ID}            wnd[0]/usr/txtVEKP-EXIDV2
${Txt_InboudASN}        wnd[0]/usr/ctxtLIKP-VBELN
${Txt_Material}         wnd[0]/usr/tabsTAXI_TABSTRIP_OVERVIEW/tabpT\\01/ssubSUBSCREEN_BODY:SAPMV50A:1202/tblSAPMV50ATC_LIPS_OVER_INB/ctxtLIPS-MATNR[1,0]
${Txt_MaterNumber}      wnd[0]/usr/ctxtS_MATNR-LOW
${Txt_PackMaterial}     wnd[0]/usr/tabsTS_HU_VERP/tabpUE6POS/ssubTAB:SAPLV51G:6010/tblSAPLV51GTC_HU_001/ctxtV51VE-VHILM[2,0]
${Txt_Plant}            wnd[0]/usr/ctxtSP$00023-LOW
${Txt_PurchasDoc}       wnd[0]/usr/ctxtSP$00005-LOW
${Txt_PurchasGroup}     wnd[0]/usr/ctxtSP$00006-LOW
${Txt_SelecParam}       wnd[0]/usr/ctxtSP$00010-LOW
${Txt_WMSSupplier}      wnd[0]/usr/txtVEKP-SPE_IDENT_01
${prg_winium}
${prg_sapgui}
*** Test Cases ***
Scenario: Update Business Partner Info
  [tags]    sap
  Given that the user is logged into PartLinQ
  When the user update the Business Partner
  Then inform the BP Number and update the informations

*** Keywords ***
### Given ###
that the user is logged into PartLinQ
  ${title}    Get Value    ${SAP_Title}
  Should Be Equal    ${title}    SAP Easy Access ${SPACE}-${SPACE} User Menu for test ID for automated Test Scripts 1

### When ###
the user update the Business Partner
  Run Transaction     VL31N
  Send Vkey           Shift + F4
  Input Text          ${Txt_MaterNumber}      VO 82713508
  Input Text          ${Txt_PurchasDoc}       1000005844
  Set Focus           ${Txt_PurchasGroup}
  Send Vkey           F2
  Click Element       ${Btn_DeleteRow}
  Set Focus           ${Txt_DocCategory}
  Send Vkey           F2
  Click Element       ${Btn_DeleteRow}
  Set Focus           ${Txt_SelecParam}
  Send Vkey           F2
  Click Element       ${Btn_DeleteRow}
  Set Focus           ${Txt_Plant}
  Send Vkey           F2
  Click Element       ${Btn_DeleteRow}
  Send Vkey           F8
  Select Table Row    ${Tab_DocsXVendor}      0
  Send Vkey           F8
  Input Text          ${Txt_DeliveryQtd}      5
  Set Focus           ${Txt_Material}
  Send Vkey           F2
  Click Element       ${Tab_ItemAdmin}
  Input Text          ${Txt_ExtItem}          10
  Send Vkey           F8
  Click Element       ${Tab_HeaderAdmin}
  Input Text          ${Txt_ExtID}            MY_ASN_05
  Send Vkey           F3
  Send Vkey           F3
  Select Table Row    ${Tab_AllItems}         0
  Send Vkey           Shift + F6
  Input Text          ${Txt_PackMaterial}    PALLET
  Send Vkey           ENTER
  ${HandlingUnit} =   Get Value              ${Txt_HandlingUnit}
  Set Focus           ${Txt_HandlingUnit}
  Send Vkey           F2
  Input Text          ${Txt_WMSSupplier}     ${HandlingUnit}
  Input Text          ${Txt_HU_ID}           ${HandlingUnit}
  Send Vkey           F3
  Select Table Row    ${Tab_AllHUs}          0
  Select Table Row    ${Tab_MatBePacked}     0
  Click Element       ${Btn_Pack}
  Send Vkey           CTRL + S
  Click Element       ${Menu_Display}
  ${InboudASN} =      Get Value              ${Txt_InboudASN}

### Then ###
inform the BP Number and update the informations
  No Operation

### Suit Setup
Connect PartLinQ
  ${prg_winium} =    Start Process      ${Winium}
  Set Global Variable    ${prg_winium}    ${prg_winium}
  ${prg_sapgui} =    Start Process      ${Saplogon}
  Set Global Variable    ${prg_sapgui}    ${prg_sapgui}
  Wait Until Keyword Succeeds    30s    1s    Connect To Session
  Open Connection    ${Con_Name}
  Input Text        /app/con[0]/ses[0]/wnd[0]/usr/txtRSYST-BNAME    ${Username}
  Input Password    /app/con[0]/ses[0]/wnd[0]/usr/pwdRSYST-BCODE    ${Password}
  Send Vkey          Enter

### Suit Teardown
Close PartLinQ
  Terminate Process   ${prg_winium}
  Terminate Process   ${prg_sapgui}