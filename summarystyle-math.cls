% summarystyle-math.cls
% LaTeX class for mathematics-focused summaries/lecture notes.
% Derived from previous ITH variant; tuned for strict definitions, theorems and proofs.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{summarystyle-math}[2025/10/24 v1.0 Summary Style (math-focused)]

% Base
\LoadClass{report}

% Encoding and language
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[german]{babel}

% Math packages
\RequirePackage{amsmath,amsfonts,amssymb,dsfont,latexsym,physics}

% Theorem tooling
\RequirePackage{amsthm}
\RequirePackage{thmtools}

% Graphics, framing and layout
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{mdframed}
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable}
\RequirePackage[a4paper, margin=2.5cm]{geometry}

% Hyperref and cleveref
\RequirePackage{hyperref}
\hypersetup{colorlinks=true, linkcolor=black, citecolor=green, urlcolor=cyan}
\RequirePackage[german]{cleveref}

% Load centralized common commands
\RequirePackage{common-commands}

% Title / metadata helpers
\newcommand{\lecturer}[1]{\gdef\@lecturer{#1}}
\newcommand{\semester}[1]{\gdef\@semester{#1}}
\gdef\@lecturer{} \gdef\@semester{}

% Theorem-like environments (German naming, shared counter)
\declaretheorem[style=plain, name=Definition, within=chapter]{definition}
\declaretheorem[sibling=definition, style=plain, name=Satz]{theorem}
\declaretheorem[sibling=definition, style=plain, name=Lemma]{lemma}
\declaretheorem[sibling=definition, style=plain, name=Korollar]{corollary}
\declaretheorem[sibling=definition, style=definition, name=Beispiel]{example}
\declaretheorem[sibling=definition, style=remark, name=Bemerkung]{remark}

% Frame important statements
\mdfdefinestyle{summarytheoremstyle}{linecolor=black, linewidth=0.5pt, backgroundcolor=gray!10}
\surroundwithmdframed[style=summarytheoremstyle]{theorem}
\surroundwithmdframed[style=summarytheoremstyle]{definition}
\surroundwithmdframed[style=summarytheoremstyle]{lemma}
\surroundwithmdframed[style=summarytheoremstyle]{corollary}

% Simple maketitle
\makeatletter
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \centering\vspace*{2cm}
    {\LARGE\bfseries\@title\par}\vspace{1cm}
    {\large \@lecturer \par}\vspace{0.5cm}
    {\normalsize \@semester \par}\vspace{2cm}
    {\large Zusammengefasst von: \@author\par}
  \end{titlepage}
}
\makeatother

\endinput
