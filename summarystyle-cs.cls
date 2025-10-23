% summarystyle-cs.cls
% LaTeX class for CS-focused summaries/lecture notes.
% Derived from previous datenbanken variant; tuned for general CS lectures and examples.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{summarystyle-cs}[2025/10/24 v1.0 Summary Style (CS-focused)]

\LoadClass{report}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english,german]{babel}

\RequirePackage{amsmath,amssymb,dsfont,latexsym}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{caption,subcaption}
\RequirePackage{enumitem}
\RequirePackage[a4paper, margin=2.5cm]{geometry}
\RequirePackage{xcolor}
\RequirePackage{mdframed}
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable}

\RequirePackage{hyperref}
\hypersetup{colorlinks=true, linkcolor=black, citecolor=green, urlcolor=cyan}
\RequirePackage[german]{cleveref}

% Load centralized common commands
\RequirePackage{common-commands}

% Title helpers
\newcommand{\lecturer}[1]{\gdef\@lecturer{#1}}
\newcommand{\semester}[1]{\gdef\@semester{#1}}
\gdef\@lecturer{} \gdef\@semester{}

% Theorem-like envs (more example-focused)
\RequirePackage{amsthm}
\declaretheorem[style=definition, name=Definition, within=chapter]{definition}
\declaretheorem[style=definition, name=Theorem, sibling=definition]{theorem}
\declaretheorem[style=definition, name=Lemma, sibling=definition]{lemma}
\declaretheorem[style=definition, name=Example, sibling=definition]{example}
\declaretheorem[style=remark, name=Remark, sibling=definition]{remark}

% framed examples
\mdfdefinestyle{examplebox}{linecolor=black, backgroundcolor=green!6}
\surroundwithmdframed[style=examplebox]{example}

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
