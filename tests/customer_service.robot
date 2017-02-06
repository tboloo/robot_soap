*** Settings ***
Documentation     Example test cases using the data-driven testing approach.
...
...               All tests contain a workflow constructed from keywords in
...               ``CustomerServiceLibrary.py``. Creating new tests or editing
...               existing is easy even for people without programming skills.
...
...               The _keyword-driven_ appoach works well for normal test
...               automation, but the _gherkin_ style might be even better
...               if also business people need to understand tests. If the
...               same workflow needs to repeated multiple times, it is best
...               to use to the _data-driven_ approach.
Library           ../lib/CustomerServiceLibrary.py
Metadata          Version    0.1

*** Variables ***
${N}   10

*** Test Cases ***
Create new customer
    As an operator
    I can create new customer

Create N new customers
    As an operator
    I can create "${N}" new customers

Get existing customer
    As an operator
    I can get existing customer "1"

*** Keywords ***
As an operator
    No operation

I can create new customer
    ${result} =  Create customer    1
    Should Be Equal     ${result}   ok

I can create "${N}" new customers
    : FOR    ${i}    IN RANGE    1    ${N}
    \   Log to console      Creating customer ${i}
    \   ${result} =         Create customer    ${i}
    \   Should Be Equal     ${result}   ok

I can get existing customer "${id}"
    ${customer} =   Get Customer    ${id}
    Should Contain  ${customer}     person
