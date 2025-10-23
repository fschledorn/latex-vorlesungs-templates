Exercise sheets (exercise_sheets.cls)
-----------------------------------

Short notes for the exercise sheet class I use in tutorials and assignments.

Usage

Place the class file next to your document (or reference the repository as a submodule) and use:

```tex
\documentclass{path/to/exercise_sheets}
```

Features

- KOMA-based layout with simple metadata commands (\semester, \modul, \blattnr, \gruppenmitglieder, \tutor, \abgabedatum)
- `aufgabe` / `subaufgabe` environments for tasks and sub-tasks
- Helpers to collect points and produce a points table (`\points`, `\makepointstable`)

Macros standardized here: `\R`, `\N`, `\set{}`, `\spa`, `\scalprod{}` and others—these match the other summary classes.

Attribution

See top-level `README.md` for license and attribution details.
