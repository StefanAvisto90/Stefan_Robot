*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.avisto-eastern.com/

*** Test Cases ***
TC4: Check Case Studies Menu
    [Documentation]    This test case verifies the behavior of the "Case Studies" menu.
    ...                It checks that hovering over the "Case Studies" menu does not reveal any sub-menu items,
    ...                clicking the "Case Studies" menu item navigates to the case studies page, and clicking
    ...                the Avisto logo navigates back to the homepage.
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

    Mouse Over Case Studies Menu
    Click Case Studies Menu Item
    Click Avisto Logo

    Close Browser

*** Keywords ***
Mouse Over Case Studies Menu
    [Documentation]    This keyword hovers the mouse over the "Case Studies" menu and ensures no sub-menu items are displayed.
    ...                 Not sure how to test that
    mouse over    xpath=//span[normalize-space(text())='Case Studies']
    Element Should Not Be Visible    xpath=//li[@id='nav-menu-item-18457']//div[@class='inner']

Click Case Studies Menu Item
    [Documentation]    This keyword clicks the "Case Studies" menu item and verifies that the URL is correct (https://www.avisto-eastern.com/case-studies/).
    Click Element    //span[normalize-space(text())='Case Studies']
    Title Should Be    Case Studies < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/case-studies/

Click Avisto Logo
    [Documentation]    This keyword clicks the Avisto logo and verifies that the homepage is opened (https://www.avisto-eastern.com/).
    Click Image         xpath=//img[@class='mobile']
    Title Should Be    Home < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/
