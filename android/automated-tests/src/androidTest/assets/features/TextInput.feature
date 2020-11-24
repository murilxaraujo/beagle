#
# Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

@textinput @regression
Feature: TextInput Validation

    As a Beagle developer/user
    I'd like to make sure my textInput work as expected

    Background:
        Given the Beagle application did launch with the textInput on screen

    Scenario Outline: TextInput 01 - validate value field if filled
        Then I must check if the textInput value <textInputValue> appears on the screen

        Examples:
            | textInputValue            |
            | TextInput test            |
            | TextInput with expression |

    Scenario Outline: TextInput 02 - validate placeholder field if filled
        Then I must check if the textInput placeholder <textInputPlaceholder> appears on the screen

        Examples:
            | textInputPlaceholder                  |
            | TextInput placeholder                 |
            | TextInput placeholder with expression |

    Scenario Outline: TextInput 03 - validate disabled field
        When the disabled textInput <textInputDisabled> is visible
        Then verify if it's <textInputDisabled> disabled

        Examples:
            | textInputDisabled                                 |
            | Standard text with disabled field                 |
            | Standard text with disabled field with expression |

    Scenario Outline: TextInput 04 - validate readOnly field
        When the value <textInputReadOnly> of the readOnly field is on the screen
        Then verify if the field with the value <textInputReadOnly> is read only

        Examples:
            | textInputReadOnly            |
            | is Read Only                 |
            | is Read Only with expression |

    Scenario Outline: TextInput 05 - validate keyboard appears on Focus
        When I click in the textInput with the placeholder <textInputSecondPlan>
        Then verify if the text <textInputSecondPlan> is in the second plan

        Examples:
            | textInputSecondPlan                           |
            | is a textInput in second plan                 |
            | is a textInput in second plan with expression |

    Scenario Outline: TextInput 06 - validate date entry when using "date" type
        Then validate if the text Input component <textInputTypeDate> hint with the date type

        Examples:
            | textInputTypeDate            |
            | writing date                 |
            | writing date with expression |

    Scenario Outline: TextInput 07 - validate textInput of type email
        Then validate if the text Input component <textInputTypeEmail> hint with the e-mail type

        Examples:
            | textInputTypeEmail             |
            | writing e-mail                 |
            | writing e-mail with expression |

    Scenario Outline: TextInput 08 - validate textInput of type password
        Then validate if the text Input component <textInputTypePassword> hint with the password type

        Examples:
            | textInputTypePassword            |
            | writing password                 |
            | writing password with expression |

    Scenario Outline: TextInput 09 - validate textInput of type number
        Then validate if the text Input component <textInputTypeNumber> hint with the number type

        Examples:
            | textInputTypeNumber            |
            | writing number                 |
            | writing number with expression |

    Scenario Outline: TextInput 10 - validate textInput of type text
        Then validate if the text Input component <textInputTypeText> hint with the text type

        Examples:
            | textInputTypeText            |
            | writing text                 |
            | writing text with expression |

    Scenario Outline: TextInput 11 - validate keyboard with type "number"
        Then validate attribute of "type number" of textInput component <textInputTypeNumber>

        Examples:
            | textInputTypeNumber                      |
            | is textInput type number                 |
            | is textInput type number with expression |

    Scenario: TextInput 12 - validate textInput with action onFocus
        When I click the textInput with the placeholder action validation
        Then the textInput with the placeholder "Unordered actions" will change its value to DidOnFocus

    Scenario: TextInput 13 - validate textInput with action onChange
        When I click the textInput with the placeholder action validation
        And I type anything on textInput with the placeholder action validation
        Then the textInput with the placeholder "Unordered actions" will change its value to DidOnChange

    Scenario: TextInput 14 - validate textInput with action onBlur
        When I click the textInput with the placeholder action validation
        And I click the textInput with the placeholder is textInput type number
        Then the textInput with the placeholder "Unordered actions" will change its value to DidOnBlur

    Scenario: TextInput 15 - validate the actions of the textInput when they're executed in sequence
        When I click the textInput with the placeholder action order
        And I type anything on textInput with the placeholder action order
        And I click the textInput with the placeholder is textInput type number
        Then the textInput with the placeholder "Ordered actions" should have value DidOnFocusDidOnChangeDidOnBlur

    Scenario Outline: TextInput 16 - validate that textInput is hidden
        Then The hidden input fields <textInputHidden> should not be visible

        Examples:
            | textInputHidden                     |
            | this text is hidden                 |
            | this text is hidden with expression |
