# Code style and code organization requirements for testing code

This document describes requirements for testing code that apply in any language. Translate the examples to the target language as needed.

## Unit tests

### Code style

* Every test must be organized in three sections: Given, When, Then.
    Example:
    ```py
    def test():
        # Given
        # <Code to prepare data and set up the test>

        # When
        # <Call to the unit under test, e.g. the one function that is being tested>

        # Then
        # <Code to verify if the actual return value matches the expectations>
    ```
    This format applies for all but the most trivial tests.
* Keep related tests together. Sort related tests from simple to complex.
* Tests should test public interfaces (functions, methods, classes), not private ones.
* Every test should create its own fixtures. Avoid creating shared fixtures; especially annoying are shared fixtures whose features are not used by all tests every time.

### Coverage

All branches of the unit must be tested.
