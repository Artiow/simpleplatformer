## Project Overview

This repository contains a 2D side-scrolling platformer developed with **Godot 4.4** using **GDScript 2.0**.
It is an educational project focused on code quality, architectural clarity, and using Godot’s native features effectively.

## Agent Instructions

Automated assistants working on this repository should follow these principles:

### Language & Formatting
- Use **GDScript 2.0** syntax and features.
- Use **tabs** for indentation (not spaces).

### Code Style & Design
- Code must be **readable**, **self-documenting**, and **extensible**.
- Favor **minimal, direct, and focused** changes when fixing or refactoring.
- Avoid introducing unnecessary abstractions or layers of complexity.

### Architecture & Engine Usage
- Prefer **Godot's built-in systems** where appropriate.
- Avoid tight coupling between components. Apply **separation of concerns**.
- Follow and preserve the architectural decisions already present in the project.
- Do not use deprecated APIs from Godot 3.x or early 4.x releases.

### Safe Execution & Deferral
- When using `call_deferred`, prefer the **type-safe form**:
  ```gdscript
  method.call_deferred()
  ```
  instead of:
  ```gdscript
  call_deferred("method")
  ```

### Documentation & AI Collaboration
- Maintain concise, structured documentation (e.g., in Markdown) describing architecture, key workflows, and intent.
- AI assistants rely on this documentation to understand *why* code exists, not just *how* it works.
- Prefer clear, intention-revealing code and comments. Assistants will mirror the tone and style of the codebase.
- Keep changes minimal and well-scoped. Assistants work best when given clear, constrained goals.
- Document key architectural concepts in a way that persistent-memory AIs can reference and align with over time.

### `.aidocs` Reference
The `/.aidocs/` folder stores persistent AI-facing documents. Each file is self-contained:
- **aidocs-guidelines.md** – how to create and update AI documentation.
- **architecture.md** – explains directory layout and how scenes, scripts and resources connect.
- **nodes.md** – conventions for custom node scripts in `scripts/core/objects/nodes`.
- **resources.md** – explanation of resource scripts and data files.
- **conventions.md** – safe execution patterns and other project-wide practices.
