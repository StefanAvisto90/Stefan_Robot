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
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight / 3);
    sleep    3s

    Check Expertise Links
    #Check Useful Links
    Close Browser

*** Keywords ***
Check Expertise Links
    ${links}=    Create List    Application Software    Embedded Software    DevOps    Quality Assurance    Industrial Automation
    FOR    ${link}    IN    @{links}
        ${UPPER_TEXT}=    Evaluate    '${link}'.upper()
        Check Link Exists    ${UPPER_TEXT}
    END

Check Useful Links
    ${links}=    Create List    Contact Us    Open Positions    ISO certificates    Case Studies
    FOR    ${link}    IN    @{links}
        ${UPPER_TEXT}=    Evaluate    '${link}'.upper()
        Check Link Exists    ${UPPER_TEXT}
    END

Check Link Exists
    [Arguments]    ${link_name}
    Element Should Be Visible       //h2[normalize-space()='${link_name}']
