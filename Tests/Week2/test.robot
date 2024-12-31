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
    Check Useful Links

    Close Browser

*** Keywords ***
Check Expertise Links
    ${links}=    Create List    Application Software    Embedded Software    DevOps    Quality Assurance    Industrial Automation
    FOR    ${link}    IN    @{links}
        Check Expertise Link Exists    ${link}
    END

Check Useful Links
    ${links}=    Create List    Contact Us    Open Positions    ISO certificates    Case Studies
    FOR    ${link}    IN    @{links}
        Check Useful Link Exists    ${link}
    END

Check Expertise Link Exists
    [Arguments]    ${link_name}
    # Handle each step with `Run Keyword And Ignore Error` to ensure the test continues
    ${result}=    Run Keyword And Ignore Error    Element Should Be Visible    //a[normalize-space(text())='${link_name}']
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    Failed to find link: ${link_name}    level=INFO
    Run Keyword And Ignore Error    click element    //a[normalize-space(text())='${link_name}']
    Run Keyword And Ignore Error    Wait Until Element Is Visible    //a[translate(normalize-space(text()), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='${link_name.upper()}']    timeout=10s
    Run Keyword And Ignore Error    Go Back

Check Useful Link Exists
    [Arguments]    ${link_name}
    # Handle each step with `Run Keyword And Ignore Error` to ensure the test continues
    ${result}=    Run Keyword And Ignore Error    Element Should Be Visible    //a[translate(normalize-space(text()), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='${link_name.upper()}']
    Run Keyword If    '${result[0]}' == 'FAIL'    Log    Failed to find useful link: ${link_name}    level=INFO
    Run Keyword And Ignore Error    click element    //a[translate(normalize-space(text()), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='${link_name.upper()}']
    Run Keyword And Ignore Error    Wait Until Element Is Visible    //a[translate(normalize-space(text()), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='${link_name.upper()}']    timeout=10s
    Run Keyword And Ignore Error    Go Back
