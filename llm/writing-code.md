# Instructions for writing code

This document describes requirements for code that apply in any language. Translate the examples to the target language as needed.

## In general

Focus. Do not add/remove/modify any code unrelated to your task without asking the user for permission. Do not write logic that is not strictly necessary for the task.

Preserve comments. Related to the rule above, as a rule, preserve code comments when modifying code. When in doubt whether to modify or delete a comment, ask the user.

Comment why, not what. Comments must add information a reader cannot quickly get from the code itself: a why, an invariant, a constraint, a reference, the meaning of a magic value, or a usage summary at the top of a file or script. Do not paraphrase the next line(s) of code in English. Length scales with complexity. A subtle algorithm or hidden constraint may warrant several lines. A self-evident line gets no comment at all.

Warn about bugs. If you detect likely test bugs, stop whatever you were doing and inform the user. This is more important than continuing your task.

Seek help. If you run into problems that you are not allowed to fix according to your instructions, ask the user for help.

Get approval. Do not make any changes without the user's explicit approval.

Follow SOLID principles.

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

* Use immutable data structures (e.g. Python dataclasses/Pydantic models, Scala case classes) to model API requests and responses, internal domain objects, DTOs, etc.

## Documentation

* Every public class, function and method that is not a unit test must be documented.
* When changing a class, function or method, ensure its documentation is up-to-date after making the change.

## Functional programming style

* Default to pure functions: return new values, don't mutate inputs, don't use mutable variables.
* Push side effects (e.g. input/putput, state mutation) to the 'edges' of the program, encapsulating them in functions. Pass the effectful functions to pure functions that call them (dependency injection).
* Avoid the use of `break`, `continue` and multiple `return` statements in functions and loops.
* Prefer functional approaches like map(), filter(), reduce() over loops.

## Testing

See [Writing test code](./writing-code-testing.md)

## Language-specific requirements

[Writing Python code](./writing-code-python.md)
