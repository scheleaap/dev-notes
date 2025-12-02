# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About this document

* ALL instructions within this document MUST BE FOLLOWED, these are not optional unless explicitly stated.
* ASK FOR CLARIFICATION if you are uncertain about anything within the document.

## Working method

* You MUST continue working until ALL requirements have been fulfilled.
* If you are asked to check if your code work and you encounter errors, assume that they are caused by your changes. Do not accept the errors but fix them.
* DO NOT edit more code than you have to.
* It is CRITICAL that you implement all code using a test-driven development approach. Follow the red/green/refactor process:
  1. Do not change the implementation before writing a unit test.
  2. Implement ONE new unit test or extend an existing unit test.
  3. Run all unit tests of the affected test file. The newly implemented unit test must fail.
  4. Make changes to the code of the unit under test.
  5. Run all unit tests of the affected test file. The newly implemented unit test must pass.
  6. Refactor the code of the unit under test, if necessary.
  7. Run all unit tests of the affected test file. The newly implemented unit test must pass.
  You MUST NOT write any code unless a unit test will fail without it.
  You MUST NOT write/extend more than one unit test at a time.
  In your output, you must prove that you used TDD during your work.
* Follow SOLID principles.

## Programming language

* All code must be written in Python.

## Project management

* The project and its dependencies must be defined in `pyproject.toml`
* Use `uv` as dependency manager. Install packages with `uv add <package name(s)>`

## Code organization

* All regular code lies under the `src/` folder
* All testing code lies under the `test/` folder
* Organize code into domain-specific subdirectories (e.g., `customer/`, `order/`)

## Dependencies

* Use the `logging` module to write messages to stdout/stderr
* Use Typer creating a CLI
* Use PyTest for testing
* Use httpx as HTTP client and [httpx-retries](https://will-ockmore.github.io/httpx-retries/) for retrying failed HTTP calls

### Functional programming style

* Default to pure functions: return new values, don't mutate inputs.
* Push side effects (e.g. input/putput, state mutation) to the 'edges' of the program, encapsulating them in functions. Pass the effectful functions to pure functions that call them (dependency injection).
* Avoid the use of `break`, `continue` and multiple `return` statements in functions and loops.
* Prefer list (and set, dictionary) comprehensions and functional approaches like map(), filter(), reduce() over for loops.
* Prefer Python list (and set, dictionary) comprehensions over functions like map(), filter(), reduce().

### Dependency injection

* Use a functional style with dependency injection via higher-order functions to make the code:
  * Highly testable (easy to mock functions)
  * Decoupled (core logic doesn't know about clients)
  * Clear separation of concerns
* Functions and classes must:
  * Accept dependencies as **callback functions** or **objects** with minimal parameters
  * Remain pure by not directly importing or instantiating other classes
* If functions are part of a class, dependencies must be injected into the class
* The top-level code (e.g. `main()`) must:
  * Instantiate all dependencies with configuration
  * Create callback functions using lambda expressions to pre-bind configuration
  * Pass callbacks to business logic functions
* Example:
  ```python
  def sync(
      prepare_fn: Callable[[], None],
      load_users_fn: Callable[[], list[Campaign]],
      get_orders_fn: Callable[[Campaign], None],
  ):
      pass

  def main():
      with ApiClient(base_url=config.api_url, token=config.token, max_retries=config.max_retries) as api_client:
          load_users_fn = lambda: filter_users(config.user_ids, api_client.get_users())
          get_orders_fn = lambda user, since: api_client.get_orders(user, since)
          sync(load_users_fn=load_users_fn, get_orders_fn=get_orders_fn)
  ```


### Code complexity

* A function or class must have *just one* clearly defined responsibility.
* Prefer code with low complexity by taking following aspects into account:
  * Cyclomatic complexity
  * Number of function decorators (lower is better)
  * Number of arguments (lower is better)
  * Number of annotations (higher is better)
  * Number of local variables (lower is better)
  * Number of returns, yields, awaits (lower is better)
  * Number of statements and expressions (lower is better)
* If a function is more than 50 lines long, this may be an indication it has too many responsibilites and needs to be decomposed.


## Data modeling

* Use immutable Pydantic classes or immutable Python dataclasses to model API requests and responses, internal domain objects, DTOs, etc.
* Use typed domain models throughout business logic (never pass raw `dict` types)
* If Pydantic models share configuration, factor it out:
  ```python
  PYDANTIC_COMMON_CONFIG = ConfigDict(
      extra="allow",
      frozen=True,
  )

  class UserApiResponse(BaseModel):
      # ...
      model_config = PYDANTIC_COMMON_CONFIG
  ```

## External services

When working with external services (e.g. external APIs, databases):

* Encapsulate external service interactions in **client classes** (e.g., `ApiClient`, `DatabaseClient`)
* Client classes must:
  * Store configuration (credentials, retry settings) as instance variables
  * Implement context manager protocol (`__enter__`/`__exit__`) for resource lifecycle management, if wrapping an internal client object
  * Accept and return domain objects (not primitive types or raw dictionaries)
* Separate **API response models** from **domain models**:
  - API response models: use Pydantic `BaseModel` with `Field(alias=...)` for field mapping
  - Domain models: represent business concepts, use Pydantic's `BaseModel` or Python's `@dataclass`
  - Example:
    ```python
    # API response model
    class UserApiResponse(BaseModel):
        user_id: str = Field(alias="id", description="User ID")
        full_name: str = Field(alias="name", description="Full name")
        model_config = ConfigDict(
            extra="allow",
            frozen=True,
        )
    
    # Domain model
    @dataclass(frozen=True)
    class User:
        id: str
        name: str
        email: str
        created_at: datetime
    ```

## Documentation

* Every public function/method that is not a unit test must be documented with a docstring.
* When changing a function or class, also ensure its documentation is up-to-date after making the change.
* Use Sphinx' reStructuredText format as docstring format.

## Testing

* Every test must be organized as follows:
    ```py
    def test():
        # Given
        # <Code to prepare data and set up the test>

        # When
        # <Call to the unit under test, e.g. the one function that is being tested>

        # Then
        # <Code to verify if the actual return value matches the expectations>
    ```
* Keep related tests together. Sort related tests from simple to complex.

## Typing

* Use modern Python 3.10+ type syntax: `list[T]` instead of `List[T]`, `dict[K, V]` instead of `Dict[K, V]`
* Use union types with `|` operator: `User | None` instead of `Union[User, None]` or `Optional[User]`
* Import from `collections.abc` for abstract types: `collections.abc.Iterator`, `collections.abc.Callable`
* Specify callable signatures fully with input and output types: `Callable[[User, datetime | None], list[Order]]`

## Logging

* Use appropriate log levels: `debug` for detailed flow, `info` for key milestones, `warning` for recoverable issues
* Keep log messages concise and action-oriented

## Error handling

* Keep error messages concise, add context through exception chaining with `from e`
* Custom exception must:
  * Be name the subsystem: `ApiError`, `DatabaseError` (not `ApiClientError`)
  * Implement `__str__` methods on custom exceptions to format error details
* Structure exception handling as:
    ```python
    except SpecificError as e:
        raise SubsystemError("Concise message") from e
    ```

## Naming

* Function names should include a verb: `calculate_score()` not `score()` or `score_calulator()`  
* Use descriptive names: `calculate_user_score` not `calc_score` or `sc`
* Abbreviations of 3+ letters treated as words: `ApiClient` not `APIClient`, `HttpError` not `HTTPError`

## Other

* Use f-strings consistently to format messages: `f"Processing {count} items"`. Do not use printf-style formatting: ~~`logger.info("Processing %d items", count)`~~.

## Concurrency

* Use synchronous code by default
* Use async only when explicitly required by the platform or when there are clear performance benefits
