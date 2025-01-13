*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.avisto-eastern.com/
${EXPERTISE_LINKS}    Application Software, Embedded Software, DevOps, Quality Assurance, Industrial Automation
${USEFUL_LINKS}       Contact Us, Open Positions, ISO certificates, Case Studies


*** Test Cases ***
TC3: Check Main Page Footer
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    Title Should Be    Home < Avisto Eastern Europe

    Check Services Menu
    Click Services Menu Item
    Click Avisto Logo
    Close Browser

*** Keywords ***
Check Services Menu
    ${SERVICES_MENU}=    Create List    Application Software    Embedded Software    DevOps    Quality Assurance    Industrial Automation    Testimonials
    mouse over    xpath=//span[contains(text(),'Services')][1]

    FOR    ${link}    IN    @{SERVICES_MENU}
        Check Link Exists    ${link}
    END

Click Services Menu Item
    [Documentation]    This keyword clicks on the "Services" menu item using the provided XPath.
    Click Link    xpath=//li[@id='nav-menu-item-15858']//a[@href='https://www.avisto-eastern.com/expertise/']
    wait until element is visible    xpath=//h2[normalize-space()='Services']

Click Avisto Logo
    [Documentation]    This keyword clicks on the Avisto logo to return to the main homepage.
    #Wait Until Element Is Visible    xpath=//img[@class='dark']    timeout=10
    Click Image         xpath=//img[@class='mobile']

Check Link Exists
    [Arguments]    ${link_name}
    Element Should Be Visible       xpath=//span[contains(text(),'${link_name}')][1]
