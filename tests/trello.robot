*** Settings ***
Documentation   Example test cases using the keyword-driven testing approach.
...
...             All tests contain a workflow constructed from keywords in
...             ``CurrencyConverterServiceLibrary.py``. Creating new tests or editing
...             existing is easy even for people without programming skills.
...
...             The _keyword-driven_ appoach works well for normal test
...             automation, but the _gherkin_ style might be even better
...             if also business people need to understand tests. If the
...             same workflow needs to repeated multiple times, it is best
...             to use to the _data-driven_ approach.
Library         Selenium2Library
Library         ../lib/CSVLibrary.py
Library         OperatingSystem
Library         String
Library         Collections
Suite Setup     Load credentials from file, Login to Trello

#Suite Teardown     Close test browser

*** Variables ***
${BROWSER}              Chrome
${BOARD URL}            https://trello.com/b/5Jqc8m7x/robot-framework
${BOARD NAME}           Robot framework | Trello
${TASK NAME}            Trello automation example
${TODO LIST}            1
${IN PROGRESS LIST}     2
${USERNAME}             ""
${PASSWORD}             ""

*** Test Cases ***
Scenario: Add task to list
    Given I am logged in to Trello
    And I input new task "${TASK NAME}"
    Then task "${TASK NAME}" is shown on ${TODO LIST} list

Scenario: Start task
    Given I am logged in to Trello
    When I drag "${TASK NAME}" to "${IN PROGRESS LIST}" list
    Then task "${TASK NAME}" is shown on ${IN PROGRESS LIST} list

*** Keywords ***
I am logged in to Trello
    Title should be     ${BOARD NAME}

I input new task ${TASK NAME}
    Click element           xpath=//*[@id="board"]/div[1]/div/a
    Input text              xpath=//*[@id="board"]/div[1]/div/div[2]/div/div[1]/div/textarea    ${TASK NAME}
    Click element           xpath=//*[@id="board"]/div[1]/div/div[2]/div/div[2]/div[1]/input

Task ${TASK NAME} is shown on ${LIST NAME} list
    Element text should be  css=#board > div:nth-child(${LIST NAME}) > div > div.list-cards.u-fancy-scrollbar.u-clearfix.js-list-cards.js-sortable.ui-sortable > div.list-card.js-member-droppable.ui-droppable > div.list-card-details > a    ${TASK NAME}

I drag ${TASK NAME} to ${LIST NAME} list
    Drag and drop   xpath=//*[@id="board"]/div[1]/div/div[2]/div[1]/div[3]/a    xpath=//*[@id="board"]/div[2]/div/div[1]/div[1]

Load credentials from file, login to Trello
    ${credentials}=             Get File    ./data/credentials.csv
    @{COLUMNS}=                 Split String    ${credentials}    separator=,
    ${USERNAME}=                Get from list   ${COLUMNS}  0
    ${PASSWORD}=                Get from list   ${COLUMNS}  1
    Open Browser                ${BOARD URL}    ${BROWSER}
    Click element               xpath=//*[@id="content"]/div/p/a
    Wait Until Page Contains    Log in with Google
    Click element               xpath=//*[@id="google-link"]/span[2]
    Input text                  identifier=Email    ${USERNAME}
    Click element               identifier=next
    Wait Until Page Contains    ${USERNAME}
    Input password              identifier=Passwd   ${PASSWORD}
    Click element               identifier=signIn
    Wait Until Page Contains    Boards

Close test browser
    Click element   xpath=//*[@id="board"]/div[1]/div/div[1]/div[2]/a/span
    Click element   xpath=/html/body/div[5]/div/div[2]/div/div/div/ul[2]/li[2]/a
    Click element   xpath=/html/body/div[5]/div/div[2]/div/div/div/input
    Click element   xpath=//*[@id="header"]/div[4]/a[2]/span[2]
    Click element   xpath=/html/body/div[5]/div/div[2]/div/div/div/ul[3]/li/a
    Close all browsers