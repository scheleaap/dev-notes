# Code style and code organization requirements for Python code

These are Python-specific additions to the general rules.

## Project management

* The project and its dependencies must be defined in `pyproject.toml`
* Use `uv` as dependency manager. Install packages with `uv add <package name(s)>` (not `uv pip install`).

## Code organization

* All regular code lies under the `src/` folder
* All testing code lies under the `test/` folder
* Organize code into domain-specific subdirectories (e.g., `customer/`, `order/`)

## Dependencies

* Use the `logging` module to write messages to stdout/stderr
* Use Typer when creating a CLI
* Use PyTest when testing
* Use httpx as HTTP client and [httpx-retries](https://will-ockmore.github.io/httpx-retries/) for retrying failed HTTP calls

## Functional programming style

* Prefer Python list (and set, dictionary) comprehensions over functions like map(), filter(), reduce().

## Dependency injection

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

## Data modeling

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

* Use Sphinx' reStructuredText format as docstring format.
* Docstrings should describe the function of the documented class, function or method. Docstrings should not document the followed coding style.

## Testing

* Names of test functions must follow these rules:
  * If there is exactly 1 test for a unit under test, the test may be called `test_<function name>`.
  * If all tests in a file with tests test the same unit *and* the unit is the only unit in the file, the test may be called `test_<specifier>`.
  * In all other cases, unit test names must be named `test_<unit name>__<specifier>`.

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
* When handling errors, code must EITHER log the error OR raise it again, NOT both.

## Naming

* Function names should include a verb: `calculate_score()` not `score()` or `score_calulator()`  
* Use descriptive names: `calculate_user_score` not `calc_score` or `sc`
* Abbreviations of 3+ letters treated as words: `ApiClient` not `APIClient`, `HttpError` not `HTTPError`
* Use standard Python naming conventions

## Other

* Use f-strings consistently to format messages: `f"Processing {count} items"`. Do not use printf-style formatting: ~~`logger.info("Processing %d items", count)`~~.

## Concurrency

* Use synchronous code by default
* Use async only when explicitly required by the platform or when there are clear performance benefits
