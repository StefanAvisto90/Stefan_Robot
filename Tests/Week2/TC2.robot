*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.avisto-eastern.com/
${EXPERTISE_LINKS}    Application Software, Embedded Software, DevOps, Quality Assurance, Industrial Automation
${USEFUL_LINKS}       Contact Us, Open Positions, ISO certificates, Case Studies

*** Test Cases ***
TC2: Check Main Page Footer
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Title Should Be    Home < Avisto Eastern Europe
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    sleep    3s

    Check Expertise Links
    go to    ${URL}
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);

    Check Useful Links

    Close Browser

*** Keywords ***
Check Expertise Links
    [Documentation]    This keyword checks whether all expertise links on the page are visible and clickable.
    ${links}=    Create List    Application Software    Embedded Software    DevOps    Quality Assurance    Industrial Automation
    FOR    ${link}    IN    @{links}
        Check Expertise Link Exists    ${link}
    END
    
Check Useful Links
    [Documentation]    This keyword checks whether all useful links on the page are visible and clickable.
    ${links}=    Create List    Contact Us    Open Positions    ISO certificates    Case Studies
    FOR    ${link}    IN    @{links}
        Check Useful Link Exists    ${link}
    END

Check Expertise Link Exists
    [Arguments]    ${link_name}
    Run Keyword And Continue On Failure     Element Should Be Visible       //a[normalize-space(text())='${link_name}']
    Run Keyword And Continue On Failure     click element    //a[normalize-space(text())='${link_name}']
    Run Keyword And Continue On Failure     Wait Until Element Is Visible    //a[translate(normalize-space(text()), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='${link_name.upper()}']    timeout=10s
    Run Keyword And Continue On Failure     Go Back

Check Useful Link Exists
    [Arguments]    ${link_name}
    Element Should Be Visible       //a[translate(normalize-space(text()), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='${link_name.upper()}']
    click element    //a[translate(normalize-space(text()), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='${link_name.upper()}']
    Wait Until Element Is Visible    //a[translate(normalize-space(text()), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='${link_name.upper()}']    timeout=10s
    Go Back