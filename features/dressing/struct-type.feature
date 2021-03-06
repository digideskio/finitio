Feature: StructType

  Background:

    Given the System is
      """
      Age  = Integer( i | i>=0 )
      Info = <String, Age>
      """

  Scenario: Dressing a valid struct

    Given I dress JSON's '["Finitio", 1]' with Info
    Then the result should be a representation for Info

  Scenario: Dressing when an attribute is missing

    Given I dress JSON's '["Finitio"]' with Info
    Then it should be a TypeError as:
      | message                        |
      | Struct size mismatch (1 for 2) |

  Scenario: Dressing with an extra attribute

    Given I dress JSON's '["Finitio", 1, "foo"]' with Info
    Then it should be a TypeError as:
      | message                        |
      | Struct size mismatch (3 for 2) |

  Scenario: Dressing with an invalid attribute

    Given I dress JSON's '["Finitio", -1]' with Info
    Then it should be a TypeError as:
      | message                    | location |
      | Invalid value `-1` for Age |        1 |
