% summarystyle.cls
% LaTeX class for summaries/lecture notes. v1.14 - Unified Counters and German Names
% Based on the standard 'report' class.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{summarystyle}[2025/06/17 v1.14 Summary Style - Unified Counters]

% --- Base Class ---
\LoadClass{report}

% --- Required Packages ---

% Typography and Language
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[german]{babel}

% Math Packages
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{dsfont}
\RequirePackage{latexsym}
\RequirePackage{physics}

% Theorem Packages
\RequirePackage{amsthm}
\RequirePackage{thmtools}

% Graphics and Figures
\RequirePackage{graphicx}
\RequirePackage{gensymb}
\RequirePackage{caption}
\RequirePackage{enumitem}

% Colors, Framing and Drawing
\RequirePackage{xcolor}
\RequirePackage{mdframed}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta, positioning, calc}
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable}

% Page Layout
\RequirePackage[a4paper, margin=2.5cm]{geometry}

% --- Custom Commands for Title Page ---
\newcommand{\lecturer}[1]{\gdef\@lecturer{#1}}
\newcommand{\semester}[1]{\gdef\@semester{#1}}
\gdef\@lecturer{} % Initialize
\gdef\@semester{} % Initialize

% --- Load centralized common commands ---
\RequirePackage{common-commands}

% --- Additional convenience / legacy helpers (specific to script-style) ---
\newcommand{\Rnn}{\R^{n\times n}}
\newcommand{\Rmn}{\R^{m\times n}}
\newcommand{\blank}{\ensuremath{\square}}
\newcommand{\lex}{\ensuremath{\leq_{lex}}}
\newcommand{\llex}{\ensuremath{\leq_{llex}}}
\newcommand{\TM}{\ensuremath{M = (Q, \Sigma, \Gamma, \Delta, s, F)}}
\newcommand{\kTM}{\ensuremath{k}-TM}
\newcommand{\kdTM}{\ensuremath{k}-DTM}
\newcommand{\eingabein}{\ensuremath{(w_1,\dots,w_n)\in (\Sigma^*)^n}}
\newcommand{\eingabe}{\ensuremath{(w_1,\dots,w_n)}}
\newcommand{\konfig}{\ensuremath{C=(q,w_1,\dots,w_k,p_1,\dots,p_k)}}
\newcommand{\bin}{\ensuremath{\set{0,1}^*}}

% --- Theorem-like Environments with thmtools (Shared Counter) ---
% FIX: Wir definieren EINE Hauptumgebung (hier: definition), die den Zähler steuert.
% Die Nummerierung erfolgt pro Kapitel (within=chapter).
\declaretheorem[style=plain, name=Definition, within=chapter,
    refname={Definition,Definitionen}, Refname={Definition}
]{definition}

% FIX: Alle anderen Umgebungen werden als "Geschwister" (sibling) deklariert.
% Sie verwenden denselben Zähler wie die 'definition'-Umgebung und bekommen den korrekten deutschen Namen.
\declaretheorem[sibling=definition, style=plain, name=Satz, refname={Satz,Sätze}, Refname={Satz}]{theorem}
\declaretheorem[sibling=definition, style=plain, name=Lemma, refname={Lemma,Lemmata}, Refname={Lemma}]{lemma}
\declaretheorem[sibling=definition, style=plain, name=Korollar, refname={Korollar,Korollare}, Refname={Korollar}]{corollary}
\declaretheorem[sibling=definition, style=plain, name=Proposition, refname={Proposition,Propositionen}, Refname={Proposition}]{proposition}
\declaretheorem[sibling=definition, style=definition, name=Beispiel, refname={Beispiel,Beispiele}, Refname={Beispiel}]{example}
\declaretheorem[sibling=definition, style=remark, name=Bemerkung, refname={Bemerkung,Bemerkungen}, Refname={Bemerkung}]{remark}

% --- Framed Environments Style (mdframed) ---
\mdfdefinestyle{summarytheoremstyle}{%
    linecolor=black,
    linewidth=0.5pt,
    backgroundcolor=gray!20,
    innertopmargin=\topskip,
    innerbottommargin=\topskip,
}

% --- Apply Framed Style to Environments ---
\surroundwithmdframed[style=summarytheoremstyle]{theorem}
\surroundwithmdframed[style=summarytheoremstyle]{definition}
\surroundwithmdframed[style=summarytheoremstyle]{lemma}
\surroundwithmdframed[style=summarytheoremstyle]{corollary}
\surroundwithmdframed[style=summarytheoremstyle]{remark}

% --- Application Example Box (tcolorbox) ---
\newtcolorbox{anwendungsbeispiel}{
    colback=green!10!white,
    colframe=green!50!black,
    fonttitle=\bfseries,
    title=Anwendungsbeispiel,
    breakable,
    boxrule=1pt,
}

% --- Hyperlink and Referencing Packages (Load near the end) ---
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true, linkcolor=black, citecolor=green, urlcolor=cyan,
    bookmarks=true, bookmarksopen=true, bookmarksnumbered=true,
    pdfpagemode=UseOutlines
}
\RequirePackage[german]{cleveref}

% --- Redefine \maketitle ---
\makeatletter
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \centering \vspace*{\stretch{1.5}}
    {\Huge \bfseries \@title \par} \vspace{1cm}
    {\large \@lecturer \par} \vspace{0.5cm}
    {\normalsize \@semester \par} \vspace{2cm}
    {\large \@author \par}
    \vspace*{\stretch{2}} \null
  \end{titlepage}
}
\makeatother

% --- End of Class File ---
\endinput
