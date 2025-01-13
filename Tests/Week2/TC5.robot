*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.avisto-eastern.com/

*** Test Cases ***
TC5: Check About Us Menu
    [Documentation]    This test case verifies the behavior of the "About Us" menu.
    ...                It checks the following:
    ...                1. Hovering over the "About Us" menu reveals the sub-menu items.
    ...                2. Clicking the "About Us" menu item navigates to the About Us page.
    ...                3. Clicking the Avisto logo navigates back to the homepage.
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

    Hover Over About Us Menu
    Click About Us Menu Item
    Click Avisto Logo

    Close Browser

*** Keywords ***
Hover Over About Us Menu
    [Documentation]    This keyword simulates hovering the mouse over the "About Us" menu.
    ...                It ensures that the sub-menu items (such as "History", "Avisto Offices", etc.) become visible.
    ${ABOUT_US_MENU}=    Create List    History    Avisto Offices    Advans group    ISO certificates    CORPORATE SOCIAL RESPONSIBILITY    Code of conduct
    Mouse Over    xpath=//span[normalize-space(text())='About Us']
    FOR    ${link}    IN    @{ABOUT_US_MENU}
        Check Link Exists    ${link}
    END

Click About Us Menu Item
    [Documentation]    This keyword clicks the "About Us" menu item and verifies that the URL navigates to the correct About Us page.
    ...                It checks that after the click, the page URL is https://www.avisto-eastern.com/about-us/.
    Click Element    xpath=//span[normalize-space(text())='About Us']
    Title Should Be    About Us < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/about-us/

Click Avisto Logo
    [Documentation]    This keyword clicks on the Avisto logo and verifies that the homepage is opened.
    ...                It checks that after clicking the logo, the browser navigates back to the homepage URL https://www.avisto-eastern.com/.
    Click Image         xpath=//img[@class='mobile']
    Title Should Be    Home < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/

Check Link Exists
    [Arguments]    ${link_name}
    Element Should Be Visible       xpath=//span[normalize-space(text())='${link_name}']