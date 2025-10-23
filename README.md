# LaTeX Lecture Templates

A centralized collection of LaTeX class files designed for academic work, including exercise sheets, summaries, and lecture notes. This repository is designed to be included as a git submodule.

## Contents

This repository provides the following LaTeX class files:

- **`exercise_sheets.cls`** — KOMA-Script based class for exercise/problem sheets with metadata helpers, task environments, and point tracking
- **`script-style.cls`** — Report/book-style class for longer summaries or script-like documents
- **`summarystyle-math.cls`** — Math-focused summary class optimized for strict definitions, theorems, lemmas, and proofs
- **`summarystyle-cs.cls`** — CS-focused summary class with emphasis on examples, diagrams, and flexible theorem usage

All classes share a common set of mathematical macros defined in `common-commands.sty` for consistency across templates.

## Quick Start

### As a Git Submodule (Recommended)

1. **Add this repository as a submodule** to your project:

   ```bash
   git submodule add https://github.com/fschledorn/latex-vorlesungs-templates tex-templates
   git submodule update --init --recursive
   ```

2. **Reference the class** in your LaTeX document:

   ```latex
   \documentclass{tex-templates/exercise_sheets}
   % or
   \documentclass{tex-templates/summarystyle-math}
   % or
   \documentclass{tex-templates/summarystyle-cs}
   % or
   \documentclass{tex-templates/script-style}
   ```

3. **Compile** your document as usual with `pdflatex`, `latexmk`, or your preferred build tool.

### Manual Installation

Alternatively, copy the `.cls` and `.sty` files to your local TEXMF tree:

```bash
# Create local texmf directory if it doesn't exist
mkdir -p ~/Library/texmf/tex/latex/local

# Copy all class and style files
cp tex-templates/*.cls ~/Library/texmf/tex/latex/local/
cp tex-templates/*.sty ~/Library/texmf/tex/latex/local/

# Update filename database (may not be necessary on macOS/TeX Live)
mktexlsr
```

After installation, you can use the classes directly:

```latex
\documentclass{summarystyle-math}
```

## Standardized Macros

All classes in this repository load `common-commands.sty`, which provides a consistent set of mathematical macros. This makes it easy to switch between templates without changing your document content.

### Available Macros

**Number Sets:**

- `\R` — Real numbers (ℝ)
- `\N` — Natural numbers (ℕ)
- `\C` — Complex numbers (ℂ)
- `\Z` — Integers (ℤ)
- `\Q` — Rational numbers (ℚ)

**Set Notation:**

- `\set{...}` — Set braces, e.g., `\set{1,2,3}` → {1,2,3}

**Linear Algebra & Analysis:**

- `\spa` — Span operator
- `\scalprod{a}{b}` — Scalar product / inner product ⟨a, b⟩
- `\abs{x}` — Absolute value |x|
- `\norm{v}` — Norm ‖v‖

**Algorithms & Complexity:**

- `\BigO` — Big-O notation 𝒪

**Automata & Formal Languages:**

- `\Sig` — Sigma (Σ)
- `\Sigs` — Sigma-star (Σ*)

### Example Usage

```latex
\documentclass{tex-templates/summarystyle-math}

\begin{document}
Let $A = \set{1,2,3} \subseteq \N$ and consider vectors $u, v \in \R^n$.
The scalar product is $\scalprod{u}{v}$ and the norm is $\norm{v}$.
The algorithm has complexity $\BigO(n^2)$.
\end{document}
```

## Template Details

### Exercise Sheets (`exercise_sheets.cls`)

Designed for homework assignments and exercise sheets with the following features:

- **Metadata commands**: `\semester`, `\modul`, `\blattnr`, `\gruppenmitglieder`, `\tutor`, `\abgabedatum`, `\universitaet`
- **Task environments**: `aufgabe` (task) and `subaufgabe` (subtask)
- **Point tracking**: Automatic collection and display of points with `\makepointstable`
- **KOMA-Script based**: Uses `scrartcl` with customized headers and footers

**Example:**

```latex
\documentclass{exercise_sheets}

\universitaet{Universität XYZ}
\semester{Wintersemester 2025/26}
\modul{Lineare Algebra I}
\blattnr{3}
\gruppenmitglieder{Max Mustermann, Erika Musterfrau}
\tutor{Dr. Schmidt}
\abgabedatum{31.10.2025}

\begin{document}
\makepointstable

\begin{aufgabe}[Vektorräume][10]
Zeigen Sie, dass...
\end{aufgabe}

\end{document}
```

### Script Style (`script-style.cls`)

A versatile report/book-style class for longer documents:

- Based on LaTeX `report` class
- Chapter and section support
- Theorem environments with framing
- Good for comprehensive summaries and scripts
- Includes additional CS-specific macros (Turing machines, automata notation)

### Math Summary (`summarystyle-math.cls`)

Optimized for mathematics lectures with rigorous theorem-proof structure:

- **German theorem names**: Definition, Satz (Theorem), Lemma, Korollar (Corollary), Beispiel (Example), Bemerkung (Remark)
- **Framed statements**: Important theorems and definitions are visually highlighted
- **Shared counter**: All theorem-like environments share a single counter per chapter
- Suitable for pure mathematics courses

### CS Summary (`summarystyle-cs.cls`)

Tailored for computer science lectures with focus on examples:

- **Example-oriented**: Framed example environments
- **Diagram support**: TikZ and graphics packages included
- **Flexible theorem usage**: Less formal than the math variant
- Suitable for algorithms, databases, systems course

## License & Attribution

All templates in this repository are licensed under the **Creative Commons Attribution 4.0 International (CC BY 4.0)** license.

You are free to:

- **Share** — copy and redistribute the material
- **Adapt** — remix, transform, and build upon the material for any purpose

Under the following terms:

- **Attribution** — You must give appropriate credit

### Suggested Attribution

When using these templates in your documents or derivative works, please include:

> LaTeX templates by Felix Schledorn — [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

Full license text: <https://creativecommons.org/licenses/by/4.0/legalcode>

## Support

For questions, issues, or suggestions:

- Open an issue on GitHub
- Check existing issues for similar problems
- Include a minimal example when reporting bugs

---

**Repository**: <https://github.com/fschledorn/latex-vorlesungs-templates>

**Author**: Felix Schledorn
