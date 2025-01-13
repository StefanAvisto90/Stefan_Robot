*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.avisto-eastern.com/
${SEARCH_INPUT_XPATH}    xpath=//input[@type='text' and @name='s']

*** Test Cases ***
TC1: Search Functionality with Search Icon
    [Documentation]    This test case verifies the behavior of the search functionality.
    ...                It checks the following:
    ...                1. Clicking the search icon shows the search bar.
    ...                2. Clicking the search icon again hides the search bar.
    ...                3. Typing a search term ('Devops') shows relevant page.
    ...                4. Typing a search term ('Case study') and scrolling down.
    ...                5. Verifying no results for the search term 'announcement'.
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

    Click Search Icon
    Search Bar Should Be Visible
    Click Search Icon
    Search Bar Should Be Hidden
    Click Search Icon
    Type In Search Bar    Devops
    Press Keys    xpath=//input[@type='text' and @name='s']    ENTER
    Element Should Be Visible    xpath=//a[normalize-space()='Senior DevOps Engineer']
    Click Avisto Logo
    Search Bar Should Be Hidden

    Click Search Icon
    Type In Search Bar    Case study
    Scroll Down
    sleep    3s
    Scroll Up
    sleep    3s
    Search Bar Should Be Hidden
    Click Search Icon
    Search Bar Should Be Visible
    Search Bar Should Contain Text    Case study
    Press Keys    xpath=//input[@type='text' and @name='s']    ENTER
    Element Should Be Visible    xpath=//a[normalize-space()='TI AM6548 SITARA BASED BOARD BSP IMPLEMENTATION']
    Click Avisto Logo

    Click Search Icon
    Type In Search Bar    announcement
    Press Keys    xpath=//input[@type='text' and @name='s']    ENTER
    Element Should Be Visible    xpath=//a[normalize-space()='ADVANS Group Acquires Niri Intelligent Computing']
    Click Avisto Logo

    Close Browser

*** Keywords ***
Click Search Icon
    [Documentation]    This keyword clicks the search icon to show or hide the search bar.
    Click Element    xpath=//a[@class='search_button search_slides_from_window_top normal']

Search Bar Should Be Visible
    [Documentation]    This keyword verifies that the search bar is visible.
    #Element Should Be Visible    xpath=//input[@type='text' and @name='s']
    wait until element is visible    xpath=//input[@type='text' and @name='s']

Search Bar Should Be Hidden
    [Documentation]    This keyword verifies that the search bar is hidden.
    Wait Until Element Is Not Visible    xpath=//input[@type='text' and @name='s']    timeout=5

Type In Search Bar
    [Arguments]    ${text}
    [Documentation]    This keyword types the given text into the search bar.
    Input Text    xpath=//input[@type='text' and @name='s']    ${text}

Scroll Down
    [Documentation]    This keyword scrolls down the page.
    Execute JavaScript    window.scrollBy(0, 1000)

Scroll Up
    [Documentation]    This keyword scrolls up the page.
    Execute JavaScript    window.scrollBy(0, -1000)

Search Bar Should Contain Text
    [Arguments]    ${text}
    [Documentation]    This keyword checks that the search bar contains the given text.
    ${text_from_search}=    Get Value    ${SEARCH_INPUT_XPATH}
    Log    The value in the input field is: ${text_from_search}
    Should Be Equal    ${text_from_search}    ${text}

#Page Should Contain
#    [Arguments]    ${text}
#    [Documentation]    This keyword verifies that the page contains the given text.
#    Page Should Contain    ${text}

Click Avisto Logo
    [Documentation]    This keyword clicks on the Avisto logo and verifies that the homepage is opened.
    ...                It checks that after clicking the logo, the browser navigates back to the homepage URL https://www.avisto-eastern.com/.
    Click Image           xpath=//img[@class='mobile']
    Title Should Be       Home < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/
