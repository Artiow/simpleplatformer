## Project Overview

This repository contains a 2D side-scrolling platformer developed with **Godot 4.4** using **GDScript 2.0**.
It is an educational project focused on code quality, architectural clarity, and using Godot’s native features effectively.

## Agent Instructions

This document defines high-level principles and expectations for automated assistants working on this repository.
It provides strategic intent, while detailed topic-specific guidance is moved to `.aidocs/`.

Assistants should follow the principles below and consult `.aidocs/` for implementation-level conventions:

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

### Documentation & AI Collaboration
- Maintain concise, structured documentation (e.g., in Markdown) describing architecture, key workflows, and intent.
- AI assistants rely on this documentation to understand *why* code exists, not just *how* it works.
- Prefer clear, intention-revealing code and comments. Assistants will mirror the tone and style of the codebase.
- Keep changes minimal and well-scoped. Assistants work best when given clear, constrained goals.
- Document key architectural concepts in a way that persistent-memory AIs can reference and align with over time.

### `.aidocs` Reference
The `/.aidocs/` folder stores persistent AI-facing documents. Each file is self-contained and describes one subject:
- [**aidocs-guidelines.md**](./.aidocs/aidocs-guidelines.md) – instructions on writing and updating AI documentation.
- [**architecture.md**](./.aidocs/architecture.md) – an overview of the directory layout and how scenes, scripts, and resources relate to one another.
- [**conventions.md**](./.aidocs/conventions.md) – safe execution practices and other project‑wide standards.
- [**nodes.md**](./.aidocs/nodes.md) – conventions for custom node scripts under `/scripts/core/objects/nodes`.
- [**resources.md**](./.aidocs/resources.md) – conventions for custom resource scripts under `/scripts/core/objects/resources`.
