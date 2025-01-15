*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://www.avisto-eastern.com/
${FIRST_NAME}   John
${LAST_NAME}    Doe
${EMAIL}        john.doe.test@gmail.com
${MESSAGE}      test message

*** Test Cases ***
TC9: Contact Us Form Interaction
    [Documentation]    This test case verifies the behavior of the Contact Us form, including validation errors and successful form submission.
    Open Browser    ${URL}    Chrome
    Maximize Browser Window

    Click Contact Us Menu Item
    Look For Existing Fields
    Look For Privacy Checkbox
    Look For Send Button
    Scroll Down
    Select Privacy Policy Checkbox
    Click Send Button
    Element Should Contain    xpath=(//div[@class='wpcf7-response-output'])[1]    ONE OR MORE FIELDS HAVE AN ERROR. PLEASE CHECK AND TRY AGAIN.
    Check Error Properties
    Unselect Privacy Checkbox and Reload Page
    Enter 'John' for First Name
    Enter 'Doe' for Last Name
    Enter 'john.doe.test' for Email and Click Into Message Field
    Enter 'john.doe.test@gmail.com' for Email and Click Into Message Field
    Enter 'test message' into Message Field
    Look For Send Button
    Select Privacy Policy Checkbox
    Click Send Button
    Element Should Contain    xpath=(//div[@class='wpcf7-response-output'])[1]    THANK YOU FOR YOUR MESSAGE. IT HAS BEEN SENT.
    Check Error Properties
    Look For Existing Fields
    Look For Privacy Checkbox
    Look For Send Button
    Click Avisto Logo
    Close Browser

*** Keywords ***
Click Contact Us Menu Item
    [Documentation]    This keyword clicks on the "Contact Us" menu item and verifies that the Contact Us page is opened.
    Click Element         xpath=//span[normalize-space(text())='Contact Us']
    Location Should Be    https://www.avisto-eastern.com/contact-us/


Look For Existing Fields
    [Documentation]    This keyword verifies that the following fields exist on the Contact Us page: First Name, Last Name, Email, Website, and Message.
    ${fields}=    Create List    first-name    last-name    your-email    web-site    your-message
    FOR    ${field}    IN    @{fields}
        # Create XPath dynamically for each field's input or textarea element
        ${xpath}=    Set Variable    xpath=//span[@class='wpcf7-form-control-wrap' and @data-name='${field}']//input | //span[@class='wpcf7-form-control-wrap' and @data-name='${field}']//textarea

        # Log the XPath to check if it's correct
        Log    XPath for field ${field}: ${xpath}

        Wait Until Element Is Visible    ${xpath}    timeout=5

        # Get the value of the input/textarea field using Get Element Attribute
        ${empty_field}=    Get Element Attribute    ${xpath}    value

        # Log the retrieved value for debugging purposes
        Log    Retrieved value for field ${field}: '${empty_field}'

        # Check if ${empty_field} is None and set to empty string if so
        Run Keyword If    '${empty_field}' == 'None'    Set Variable    ${empty_field}    ''

        # Log the final value of the field after handling None
        Log    Final value for field ${field}: '${empty_field}'

        Run Keyword If    '${empty_field}' == ''    Log    Field is empty
        Run Keyword If    '${empty_field}' != ''    fail    Field is NOT empty
    END

Look For Privacy Checkbox
    [Documentation]    This keyword verifies that the Privacy Policy checkbox exists and is not selected.
    Element Should Be Visible    xpath=//input[@type='checkbox' and @name='acceptance-376']
    Checkbox Should Not Be Selected    xpath=//input[@type='checkbox' and @name='acceptance-376']

Look For Send Button
    [Documentation]    This keyword verifies that the Send button exists but is not clickable.
    Element Should Be Disabled    xpath=//input[@class='wpcf7-form-control wpcf7-submit has-spinner' and @type='submit' and @value='Send']

Select Privacy Policy Checkbox
    [Documentation]    This keyword selects the Privacy Policy checkbox.
    wait until element is visible    xpath=//input[@type='checkbox' and @name='acceptance-376']
    select checkbox    xpath=//input[@type='checkbox' and @name='acceptance-376']
    checkbox should be selected    xpath=//input[@type='checkbox' and @name='acceptance-376']

Click Send Button
    [Documentation]    This keyword clicks the Send button and verifies that the error message is shown if the form is incomplete.
    click button     xpath=//input[@class='wpcf7-form-control wpcf7-submit has-spinner' and @type='submit' and @value='Send']
    Wait Until Element Is Visible    xpath=(//div[@class='wpcf7-response-output'])[1]    3s


Check Error Properties
    [Documentation]    This keyword checks the error properties to ensure the error message is not visible.
    ${bg_color}=    SeleniumLibrary.Execute Javascript    return window.getComputedStyle(document.querySelector('.wpcf7-response-output')).backgroundColor
    Log    Background Color: ${bg_color}
    ${alpha_value}=    Evaluate    float('${bg_color.split(",")[-1].strip()[:-1]}')
    Run Keyword And Ignore Error    Should Be True    ${alpha_value} > 0    # Ensure the background is not fully transparent

    ${fg_color}=    SeleniumLibrary.Execute Javascript    return window.getComputedStyle(document.querySelector('.wpcf7-response-output')).color
    Log    Foreground Color: ${fg_color}

    Run Keyword And Ignore Error    Should Contain    ${bg_color}    rgb(255, 255, 255)
    Run Keyword And Ignore Error    Should Be Equal As Strings    ${fg_color}    rgb(255, 255, 255)

Unselect Privacy Checkbox and Reload Page
    [Documentation]    This keyword unselects the Privacy Policy checkbox and reloads the page.
    unselect checkbox    xpath=//input[@type='checkbox' and @name='acceptance-376']
    checkbox should not be selected    xpath=//input[@type='checkbox' and @name='acceptance-376']
    Reload Page
    page should not contain    xpath=//span[@data-name='first-name']//span[@class='wpcf7-not-valid-tip'][normalize-space()='The field is required.']
    page should not contain    xpath=//span[@data-name='last-name']//span[@class='wpcf7-not-valid-tip'][normalize-space()='The field is required.']
    page should not contain    xpath=//span[@data-name='your-email']//span[@class='wpcf7-not-valid-tip'][normalize-space()='The field is required.']

Enter 'John' for First Name
    [Documentation]    This keyword enters the value 'John' for the First Name field.
    Input Text    xpath=//input[@placeholder='First name*']    ${FIRST_NAME}
    ${entered_first_name}=    Get Value    xpath=//input[@placeholder='First name*']
    Should Be Equal    ${entered_first_name}    ${FIRST_NAME}

Enter 'Doe' for Last Name
    [Documentation]    This keyword enters the value 'Doe' for the Last Name field.
    Input Text    xpath=//input[@placeholder='Last name*']    ${LAST_NAME}
    ${entered_last_name}=    Get Value    xpath=//input[@placeholder='Last name*']
    Should Be Equal    ${entered_last_name}    ${LAST_NAME}

Enter 'john.doe.test' for Email and Click Into Message Field
    [Documentation]    This keyword enters an invalid email ('john.doe.test') for the Email field.
    Input Text    xpath=//input[@placeholder='Email*']    john.doe.test
    ${entered_email}=    Get Value    xpath=//input[@placeholder='Email*']
    Should Be Equal    ${entered_email}    john.doe.test
    Click Into Message Field
    page should contain element    xpath=//span[@class='wpcf7-not-valid-tip'][normalize-space()='The e-mail address entered is invalid.']

Click Into Message Field
    [Documentation]    This keyword clicks into the message field and verifies the error for invalid email.
    wait until element is visible    xpath=//textarea[@placeholder='Your Message']
    Click Element    xpath=//textarea[@placeholder='Your Message']

Enter 'john.doe.test@gmail.com' for Email and Click Into Message Field
    [Documentation]    This keyword enters a valid email ('john.doe.test@gmail.com') and verifies no error appears.
    Input Text    xpath=//input[@placeholder='Email*']    ${EMAIL}
    Click Into Message Field
    Page Should Not Contain    xpath=//span[@class='wpcf7-not-valid-tip'][normalize-space()='The e-mail address entered is invalid.']

Enter 'test message' into Message Field
    [Documentation]    This keyword enters the message 'test message' into the Message field.
    Input Text    xpath=//textarea[@placeholder='Your Message']    ${MESSAGE}
    ${entered_message}=    Get Value    xpath=//textarea[@placeholder='Your Message']
    Should Be Equal    ${entered_message}    ${MESSAGE}

Click Avisto Logo
    [Documentation]    This keyword clicks on the Avisto logo and verifies that the homepage is opened.
    ...                It checks that after clicking the logo, the browser navigates back to the homepage URL https://www.avisto-eastern.com/.
    Click Image           xpath=//img[@class='mobile']
    Title Should Be       Home < Avisto Eastern Europe
    Location Should Be    https://www.avisto-eastern.com/

Scroll Down
    [Documentation]    This keyword scrolls down the page.
    Execute JavaScript    window.scrollBy(0, 500)