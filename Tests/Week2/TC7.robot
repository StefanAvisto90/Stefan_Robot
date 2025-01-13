*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.avisto-eastern.com/

*** Test Cases ***
TC7: Check Blog Menu
    [Documentation]    This test case verifies the behavior of the "Blog" menu.
    ...                It checks the following:
    ...                1. Hovering over the "Blog" menu reveals no sub-menu items.
    ...                2. Clicking the "Blog" menu item navigates to the Blog page.
    ...                3. Clicking the Avisto logo navigates back to the homepage.
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

    Hover Over Blog Menu
    Click Blog Menu Item
    Click Avisto Logo

    Close Browser

*** Keywords ***
Hover Over Blog Menu
    [Documentation]    This keyword simulates hovering the mouse over the "Blog" menu.
    ...                It ensures no sub-menu items are displayed.
    Mouse Over    xpath=//span[normalize-space(text())='Blog']
    Element Should Not Be Visible    xpath=//li[@id='nav-menu-item-20109']/div


Click Blog Menu Item
    [Documentation]    This keyword clicks the "Blog" menu item and verifies that the URL navigates to the Blog page.
    ...                It checks that after the click, the page URL is https://www.avisto-eastern.com/blog/.
    Click Element    xpath=//span[normalize-space(text())='Blog']
    Title Should Be    Blog < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/blog/

Click Avisto Logo
    [Documentation]    This keyword clicks on the Avisto logo and verifies that the homepage is opened.
    ...                It checks that after clicking the logo, the browser navigates back to the homepage URL https://www.avisto-eastern.com/.
    Click Image           xpath=//img[@class='mobile']
    Title Should Be       Home < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/

