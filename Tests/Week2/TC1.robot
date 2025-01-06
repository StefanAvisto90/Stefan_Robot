*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.avisto-eastern.com/
${DESCRIPTION}    We are a service company specialized in software engineering
${TIMEOUT}    10s
${BROWSE_BUTTON}        //a[contains(@class, 'elementor-button-link') and .//span[contains(text(), 'BROWSE')]]

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
    [Documentation]    This keyword checks that the main menus exist on the page.
    @{MAIN_MENU}=    Create List       Services    Case Studies    About Us    Career    Blog    Contact Us
    FOR    ${menu}    IN    @{MAIN_MENU}
        Page Should Contain Element    xpath=//span[contains(text(),'${menu}')][1]
    END

Check For Avisto Logo
    [Documentation]    This keyword checks that the Avisto logo is present on the page.
    Page Should Contain Element    xpath=//img[@class='mobile']

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

