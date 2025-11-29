# conventions.md

This file captures execution and style conventions that are not obvious from code alone.

## Safe execution & deferral
- Prefer the type-safe form of `call_deferred`:
  ```gdscript
  method.call_deferred()
  ```
  Avoid the string-based form `call_deferred("method")` to ensure refactors remain safe.

## General approach
- Use Godot's built-in nodes and signals before adding custom layers.
- Keep scripts focused on one responsibility and expose properties with `@export`.
- Rely on signals for loose coupling between nodes.
