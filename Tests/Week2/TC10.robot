*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.avisto-eastern.com
${APPLICATION_SOFTWARE_URL}    https://www.avisto-eastern.com/expertise/application-software/
${EMBEDDED_SOFTWARE_URL}       https://www.avisto-eastern.com/expertise/embedded-software/
${DEVOPS_URL}                  https://www.avisto-eastern.com/expertise/devops/
${QUALITY_ASSURANCE_URL}       https://www.avisto-eastern.com/expertise/quality-assurance/
${INDUSTRIAL_AUTOMATION_URL}   https://www.avisto-eastern.com/expertise/industrial-automation/

*** Test Cases ***
TC10: Check links to expertise domains
    [Documentation]    This test case verifies that clicking on the "Lean more" buttons for different expertise domains navigates to the correct pages and clicking the Avisto logo returns to the main homepage.

    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Scroll Down
    # Check Application Software domain
    Click Lean More Button For Application Software
    # Check Embedded Software domain
    Click Lean More Button For Embedded Software
    # Check DevOps domain
    Click Lean More Button For DevOps
    # Check Quality Assurance domain
    Click Lean More Button For Quality Assurance
    # Check Industrial Automation domain
    Click Lean More Button For Industrial Automation
    Close Browser

*** Keywords ***
Click Lean More Button For Application Software
    [Documentation]    Clicks the "Lean more" button for the Application Software domain.
    Wait Until Page Contains Element    xpath=//section[@class='elementor-section elementor-top-section elementor-element elementor-element-58cac98 elementor-section-boxed elementor-section-height-default elementor-section-height-default parallax_section_no qode_elementor_container_no']//div[@class='elementor-container elementor-column-gap-default']
    wait until element is visible    xpath=//a[@href='https://www.avisto-eastern.com/expertise/application-software/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    click element    xpath=//a[@href='https://www.avisto-eastern.com/expertise/application-software/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    location should be    ${APPLICATION_SOFTWARE_URL}
    Click Avisto Logo
    Scroll Down

Click Lean More Button For Embedded Software
    [Documentation]    Clicks the "Lean more" button for the Embedded Software domain.
    Wait Until Page Contains Element    xpath=//section[@class='elementor-section elementor-top-section elementor-element elementor-element-58cac98 elementor-section-boxed elementor-section-height-default elementor-section-height-default parallax_section_no qode_elementor_container_no']//div[@class='elementor-container elementor-column-gap-default']
    wait until element is visible    xpath=//a[@href='https://www.avisto-eastern.com/expertise/embedded-software/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    click element    xpath=//a[@href='https://www.avisto-eastern.com/expertise/embedded-software/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    location should be    ${EMBEDDED_SOFTWARE_URL}
    Click Avisto Logo
    Scroll Down

Click Lean More Button For DevOps
    [Documentation]    Clicks the "Lean more" button for the DevOps domain.
    Wait Until Page Contains Element    xpath=//section[@class='elementor-section elementor-top-section elementor-element elementor-element-58cac98 elementor-section-boxed elementor-section-height-default elementor-section-height-default parallax_section_no qode_elementor_container_no']//div[@class='elementor-container elementor-column-gap-default']
    wait until element is visible    xpath=//a[@href='https://www.avisto-eastern.com/expertise/devops/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    click element    xpath=//a[@href='https://www.avisto-eastern.com/expertise/devops/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    location should be    ${DEVOPS_URL}
    Click Avisto Logo
    Scroll Down

Click Lean More Button For Quality Assurance
    [Documentation]    Clicks the "Lean more" button for the Quality Assurance domain.
    Wait Until Page Contains Element    xpath=//section[@class='elementor-section elementor-top-section elementor-element elementor-element-58cac98 elementor-section-boxed elementor-section-height-default elementor-section-height-default parallax_section_no qode_elementor_container_no']//div[@class='elementor-container elementor-column-gap-default']
    wait until element is visible    xpath=//a[@href='https://www.avisto-eastern.com/expertise/quality-assurance/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    click element    xpath=//a[@href='https://www.avisto-eastern.com/expertise/quality-assurance/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    location should be    ${QUALITY_ASSURANCE_URL}
    Click Avisto Logo
    Scroll Down

Click Lean More Button For Industrial Automation
    [Documentation]    Clicks the "Lean more" button for the Industrial Automation domain.
    Wait Until Page Contains Element    xpath=//section[@class='elementor-section elementor-top-section elementor-element elementor-element-58cac98 elementor-section-boxed elementor-section-height-default elementor-section-height-default parallax_section_no qode_elementor_container_no']//div[@class='elementor-container elementor-column-gap-default']
    wait until element is visible    xpath=//a[@href='https://www.avisto-eastern.com/expertise/industrial-automation/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    Click Button    xpath=//a[@href='https://www.avisto-eastern.com/expertise/industrial-automation/']//span[@class='elementor-button-content-wrapper']//span[@class='elementor-button-text'][normalize-space()='Learn More']
    location should be    ${INDUSTRIAL_AUTOMATION_URL}
    Click Avisto Logo

Click Avisto Logo
    [Documentation]    This keyword clicks on the Avisto logo and verifies that the homepage is opened.
    ...                It checks that after clicking the logo, the browser navigates back to the homepage URL https://www.avisto-eastern.com/.
    Click Image           xpath=//img[@class='mobile']
    Title Should Be       Home < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/

Scroll Down
    [Documentation]    This keyword scrolls down the page.
    Execute JavaScript    window.scrollBy(0, 1000)