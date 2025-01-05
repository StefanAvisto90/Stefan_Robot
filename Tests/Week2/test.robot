*** Settings ***
Library    SeleniumLibrary

*** Variables ***
<<<<<<< HEAD
${URL}    https://www.avisto-eastern.com/
${DESCRIPTION}    We are a service company specialized in software engineering
${CONTACT_US_BUTTON}    Contact us
${TIMEOUT}    10s
${BROWSE_BUTTON}        //a[contains(@class, 'elementor-button-link') and .//span[contains(text(), 'BROWSE')]]
#${MAIN_MENUS}    Services    Case Studies    About Us    Career    Blog    Contact Us

*** Test Cases ***
Check Main Page is Available
    [Documentation]    This test case checks if the main page of the website is available, the necessary menu items are present, the Avisto logo exists, and the "Browse" and "Contact Us" buttons are clickable.
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Page Contains    ${DESCRIPTION}    ${TIMEOUT}
    Check Available Main Menus
    Check For Avisto Logo
    Search For 'Browse' Button
    Search For 'Contact Us' Button
    Close Browser

*** Keywords ***
Check Available Main Menus
    @{MAIN_MENU}=    Create List       Services    Case Studies    About Us    Career    Blog    Contact Us
    FOR    ${menu}    IN    @{MAIN_MENU}
        Page Should Contain Element    xpath=//span[contains(text(),'${menu}')][1]
    END


Check For Avisto Logo
    [Documentation]    This keyword checks that the Avisto logo is present on the page.
    Page Should Contain Element    (//img[@class='dark'])[1]

Search For 'Browse' Button
    [Documentation]    This keyword checks if the 'Browse' button is present and clickable.
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight / 2);
    Wait Until Element Is Visible    ${BROWSE_BUTTON}    ${TIMEOUT}
    Element Should Be Enabled    ${BROWSE_BUTTON}
    #Click Element    ${BROWSE_BUTTON}

Search For 'Contact Us' Button
    [Documentation]    This keyword checks if the 'Contact Us' button is present and clickable.
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Wait Until Element Is Visible    //a[@class='elementor-button elementor-button-link elementor-size-md elementor-animation-shrink' and .//span[text()='Contact us']]    ${TIMEOUT}
    Element Should Be Enabled    //a[@class='elementor-button elementor-button-link elementor-size-md elementor-animation-shrink' and .//span[text()='Contact us']]

=======
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
>>>>>>> 148999c5385b386834b79806b31daf5cb9ffa72e
