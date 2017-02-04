*** Settings ***
Documentation     Example test cases using the keyword-driven testing approach.
...
...               All tests contain a workflow constructed from keywords in
...               ``CurrencyConverterServiceLibrary.py``. Creating new tests or editing
...               existing is easy even for people without programming skills.
...
...               The _keyword-driven_ appoach works well for normal test
...               automation, but the _gherkin_ style might be even better
...               if also business people need to understand tests. If the
...               same workflow needs to repeated multiple times, it is best
...               to use to the _data-driven_ approach.
Library           ../lib/CurrencyConverterServiceLibrary.py

*** Test Cases ***
Get conversion rate for USD and PLN
    Get conversion rate    USD  PLN
    Result should be    4.0025

Get available currencies
    ${currencies} =   Get available currencies
    Should Contain ${currencies}   "NotImplementedError"