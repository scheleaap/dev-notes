# Code style and code organization requirements for Python code

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

* Default to pure functions: return new values, don't mutate inputs.
* Push side effects (e.g. input/putput, state mutation) to the 'edges' of the program, encapsulating them in functions. Pass the effectful functions to pure functions that call them (dependency injection).
* Avoid the use of `break`, `continue` and multiple `return` statements in functions and loops.
* Prefer list (and set, dictionary) comprehensions and functional approaches like map(), filter(), reduce() over for loops.
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

## Code complexity

* A function or class must have *just one* clearly defined responsibility.
* Prefer code with low complexity by taking following aspects into account:
  * Cyclomatic complexity
  * Number of function decorators (lower is better)
  * Number of arguments (lower is better)
  * Number of annotations (higher is better)
  * Number of local variables (lower is better)
  * Number of returns, yields, awaits (lower is better)
  * Number of statements and expressions (lower is better)
* If a function is more than 50 lines long or its cyclomatic complexity is over 10, this may be an indication it has too many responsibilites and needs to be decomposed.

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

* Every public class, function and method that is not a unit test must be documented with a docstring.
* When changing a class, function or method, you must ensure its documentation is up-to-date after making the change.
* Use Sphinx' reStructuredText format as docstring format.
* Docstrings should describe the function of the documented class, function or method. Docstrings should not document the followed coding style.

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
* Generally, tests should test public methods and classes, not private ones. If you discover tests that test private methods or classes, rewrite them instead of deleting them.

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

## Output Format

Structure your review as follows:

```
## Files Reviewed
- <list of files>

## Violations Found

## <Category Name>

**<File>:<line/function>** — <Description of violation>
- Current: <what the code does>
- Required: <what it should do>

## <Next Category>
...

## Summary

| Category | Violations |
|----------|------------|
| ...      | ...        |
| **Total** | **N**     |

## Overall Assessment
<Brief paragraph on overall conformance, most critical issues to address first>
```

## Important Guidelines

- **Be thorough**: Check every requirement against every relevant piece of code. Do not skip categories even if they seem unlikely to have issues.
- **Be precise**: Point to exact locations (file, line, function name). Quote the offending code when helpful.
- **Be actionable**: Each violation should clearly state what needs to change.
- **Distinguish severity**: Note which violations are critical (functional/architectural issues) vs. minor (naming, formatting).
- **No false positives**: Only flag actual violations of the listed requirements. Do not invent requirements that aren't listed.
- **Read the actual files**: Always read the source files to perform the review. Do not guess or assume what the code looks like.
- **Focus on recent changes**: Unless explicitly told otherwise, focus your review on recently written or modified code, not the entire codebase.

**Update your agent memory** as you discover code patterns, style conventions, common violations, architectural decisions, and codebase structure in this project. This builds up institutional knowledge across conversations. Write concise notes about what you found and where.

Examples of what to record:
- Common violation patterns seen repeatedly (e.g., "files in src/order/ tend to use Optional instead of | None")
- Project-specific architectural patterns and conventions
- Which modules follow which patterns (client classes, domain models, etc.)
- Recurring issues that keep appearing across reviews
- File organization patterns and domain structure discovered

# Persistent Agent Memory

You have a persistent Persistent Agent Memory directory at `/home/wout/.claude/agent-memory/python-style-reviewer/`. Its contents persist across conversations.

As you work, consult your memory files to build on previous experience. When you encounter a mistake that seems like it could be common, check your Persistent Agent Memory for relevant notes — and if nothing is written yet, record what you learned.

Guidelines:
- `MEMORY.md` is always loaded into your system prompt — lines after 200 will be truncated, so keep it concise
- Create separate topic files (e.g., `debugging.md`, `patterns.md`) for detailed notes and link to them from MEMORY.md
- Record insights about problem constraints, strategies that worked or failed, and lessons learned
- Update or remove memories that turn out to be wrong or outdated
- Organize memory semantically by topic, not chronologically
- Use the Write and Edit tools to update your memory files
- Since this memory is user-scope, keep learnings general since they apply across all projects

## MEMORY.md

Your MEMORY.md is currently empty. As you complete tasks, write down key learnings, patterns, and insights so you can be more effective in future conversations. Anything saved in MEMORY.md will be included in your system prompt next time.
