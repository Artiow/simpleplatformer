# aidocs-guidelines

This folder stores persistent AI-facing documentation. Each file should cover a single topic so assistants can load only what they need.

## Creating new docs
- Use **Markdown** with lower-case kebab-case filenames.
- Keep each document self-contained. Do not rely on reading other `/.aidocs/` files to understand it.
- Summarize intent, architecture and style in short sections. Favor lists and short paragraphs over long prose.
- Mirror the tone of the codebase: clear, direct and free of unnecessary jargon.

## Content principles
- Follow the style and architecture rules in [AGENTS.md](../AGENTS.md).
- Document the _why_ behind patterns so AI tools can reason about decisions.
- Prefer concrete examples from the code when useful.
- Keep sections focused; break large subjects into multiple files.

## Updates
- When modifying existing docs or adding new ones, also update `AGENTS.md` with a brief description of each file.
- Ensure new docs respect Aider conventions and [Anthropic code best practices](https://www.anthropic.com/engineering/claude-code-best-practices) for clarity and maintainability.

## Coordination with AGENTS.md
- `AGENTS.md` defines high-level intent, principles, and the role of AI in the project.
- `.aidocs/` contains detailed and topic-specific supporting documentation.
- When moving any content from `AGENTS.md` to `.aidocs/`, always:
  - Remove the original section from `AGENTS.md`.
  - Optionally leave a brief cross-reference if needed.
  - Ensure `.aidocs/` fully captures the removed content in context.

