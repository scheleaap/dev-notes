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
* Test through public interfaces (functions, methods, classes), not private ones. Exception: if the public entry point needs costly setup (files, resources, network), its logic may live in a function or method it delegates to, and tests may call that delegate even if it is not public. The public entry point itself still gets at least one test.
* Every test should create its own fixtures. Avoid creating shared fixtures; especially annoying are shared fixtures whose features are not used by all tests every time. Shared helper functions that build fixtures are fine; shared fixture instances are not.
* Prefer random values in fixtures unless a value matters.

### Coverage

All branches of the unit must be tested.
