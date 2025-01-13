*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.avisto-eastern.com/

*** Test Cases ***
TC6: Check About Us Menu
    [Documentation]    This test case verifies the behavior of the "Career" menu.
    ...                It checks the following:
    ...                1. Hovering over the "Career" menu reveals the sub-menu items.
    ...                2. Clicking the "Career" menu item navigates to the Career page.
    ...                3. Clicking the Avisto logo navigates back to the homepage.
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

    Hover Over Career Menu
    Click Career Menu Item
    Click Avisto Logo

    Close Browser

*** Keywords ***
Hover Over Career Menu
    [Documentation]    This keyword simulates hovering the mouse over the "Career" menu.
    ...                It ensures that the sub-menu items (such as "Open Day", "Open Positions", etc.) become visible.
    ${CAREER_MENU}=    Create List    Open Day    Open Positions    Internships    Selection process    Benefits
    Mouse Over    xpath=//span[normalize-space(text())='Career']
    FOR    ${link}    IN    @{CAREER_MENU}
        Check Link Exists    ${link}
    END

Click Career Menu Item
    [Documentation]    This keyword clicks the "Career" menu item and verifies that the URL navigates to the correct About Us page.
    ...                It checks that after the click, the page URL is https://www.avisto-eastern.com/about-us/.
    Click Element    xpath=//span[normalize-space(text())='Career']
    Title Should Be    Career < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/career/

Click Avisto Logo
    [Documentation]    This keyword clicks on the Avisto logo and verifies that the homepage is opened.
    ...                It checks that after clicking the logo, the browser navigates back to the homepage URL https://www.avisto-eastern.com/.
    Click Image         xpath=//img[@class='mobile']
    Title Should Be    Home < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/

Check Link Exists
    [Arguments]    ${link_name}
    Element Should Be Visible       xpath=//span[normalize-space(text())='${link_name}']