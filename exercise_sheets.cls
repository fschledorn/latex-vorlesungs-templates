% exercise_sheets.cls
% Version 4.0: Refactored to use scrlayer-scrpage instead of fancyhdr
% Based on v3.9

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{exercise_sheets}[2025/05/29 v4.0 Custom Exercise Sheet Class with scrlayer-scrpage]

% --- Basisklasse und Optionen ---
\LoadClass[11pt, a4paper]{scrartcl} % Using scrartcl

% --- Benötigte Pakete ---
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage[ngerman]{babel}
\RequirePackage{amsmath} % Wird für \text in Mathemodus benötigt (RA Befehle)
\RequirePackage{dsfont}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{graphicx}
\RequirePackage{geometry}
% \RequirePackage{fancyhdr} % REMOVED: Replaced by scrlayer-scrpage
\RequirePackage{scrlayer-scrpage} % ADDED: For KOMA-Script compliant headers/footers
\RequirePackage{hyperref}
\RequirePackage{etoolbox} % Für \ifstrempty
\RequirePackage{booktabs}
\RequirePackage{xparse} % Für \NewDocumentEnvironment und \NewDocumentCommand
\RequirePackage{ifthen} % Für \ifthenelse im neuen Befehl
\RequirePackage{array}     % Für erweiterte Spaltendefinitionen (wie >{$}l<{$})
\RequirePackage{tabularx} % Für Tabellen mit anpassbarer Breite und X-Spalten
\RequirePackage[most]{tcolorbox}
\RequirePackage{float}


% --- Seitenlayout anpassen ---
\geometry{a4paper, top=3cm, bottom=3cm, left=2.5cm, right=2.5cm, headheight=27.2pt}

% --- Load centralized common commands ---
\RequirePackage{common-commands}

% --- Additional legacy helpers (specific to exercise sheets) ---
\newcommand{\cartprod}{\times}
\newcommand{\union}{\cup}
\newcommand{\intersect}{\cap}
\newcommand{\diff}{\setminus}
\renewcommand{\sin}[1]{\text{sin}\left ( #1 \right )}


% --- Metadaten-Befehle ---
% (Code bleibt unverändert)
\newcommand{\semester}[1]{\def\@semester{#1}}
\newcommand{\modul}[1]{\def\@modul{#1}}
\newcommand{\blattnr}[1]{\def\@blattnr{#1}}
\newcommand{\gruppenmitglieder}[1]{\def\@gruppenmitglieder{#1}}
\newcommand{\tutor}[1]{\def\@tutor{#1}}
\newcommand{\abgabedatum}[1]{\def\@abgabedatum{#1}}
\newcommand{\universitaet}[1]{\def\@universitaet{#1}}
\universitaet{Deine Universität}
\semester{Sommersemester 2025}
\modul{Modulname}
\blattnr{?}
\gruppenmitglieder{Namen eintragen}
\tutor{Tutor eintragen}
\abgabedatum{Datum eintragen}

% --- Kopf- und Fußzeilen mit scrlayer-scrpage --- % MODIFIED SECTION TITLE
% \pagestyle{fancy} % REMOVED
% \fancyhf{} % REMOVED

\clearpairofpagestyles % Clear KOMA's default scrheadings and scrplain page styles
                       % This is similar to \fancyhf{}

% Define header content
% For oneside documents (default for scrartcl unless 'twoside' option is given):
% \ihead is inner (left), \chead is center, \ohead is outer (right)
\ihead{\@universitaet \\ \small\@gruppenmitglieder}
\chead{\@modul \\ \@semester}
\ohead{Übungsblatt \@blattnr \\ Tutor: \@tutor}

% Define footer content
\ifoot{Gruppe: \@gruppenmitglieder}
\cfoot{\pagemark} % \pagemark is KOMA-Script's command for the page number
\ofoot{Abgabe bis: \@abgabedatum}

% Define and enable header and footer lines
\KOMAoptions{headsepline=0.4pt, footsepline=0.4pt}
% \renewcommand{\headrulewidth}{0.4pt} % REMOVED - Handled by KOMAoptions
% \renewcommand{\footrulewidth}{0.4pt} % REMOVED - Handled by KOMAoptions

\pagestyle{scrheadings} % Apply the defined header/footer settings

% --- Punkte und Namen Sammeln und Tabelle ---
% (Code bleibt unverändert)
\newcounter{totalpoints}
\setcounter{totalpoints}{0}
\newcommand{\points}[1]{%
  \ifstrempty{#1}{}{%
    \immediate\write\@auxout{\string\addpointsentry{\theaufgabennr}{#1}}%
  }%
}
\newcommand{\savename}[1]{%
    \ifstrempty{#1}{}{%
      \immediate\write\@auxout{\string\addnameentry{\theaufgabennr}{\unexpanded{#1}}}%
    }%
}
\newcommand{\addpointsentry}[2]{%
  \@namedef{points@\detokenize{#1}}{#2}%
}
\newcommand{\addnameentry}[2]{%
  \@namedef{name@\detokenize{#1}}{\detokenize{#2}}%
}
\newcommand{\makepointstable}{%
  \begingroup
  \section*{Punkteübersicht}
  \setcounter{totalpoints}{0}%
  \begin{tabular}{l l r}
    \toprule \textbf{Aufgabe} & \textbf{Name} & \textbf{Punkte} \\ \midrule
    \newcounter{taskidx}%
    \setcounter{taskidx}{0}%
    \@whilenum\value{taskidx}<\value{aufgabennr}\do{%
      \stepcounter{taskidx}%
      \number\value{taskidx} &
      \@ifundefined{name@\number\value{taskidx}}{--}{\@nameuse{name@\number\value{taskidx}}}&
      \@ifundefined{points@\number\value{taskidx}}{-- \\}{\@nameuse{points@\number\value{taskidx}} \\ \addtocounter{totalpoints}{\@nameuse{points@\number\value{taskidx}}}}%
    }%
    \midrule \multicolumn{2}{l}{\textbf{Gesamt}} & \textbf{\thetotalpoints} \\ \bottomrule
  \end{tabular} \vspace{2em} \endgroup
}


% --- Aufgaben-Umgebung (MODIFIED: Uses section* internally for isolation) ---
\newcounter{aufgabennr}
\setcounter{aufgabennr}{0}
\newcommand*{\aufgabename}{Aufgabe}

\NewDocumentEnvironment{aufgabe}{ O{} O{} } % Optional Name (#1), Optional Points (#2)
  { % Begin Code
    \refstepcounter{aufgabennr}% Increment task counter
    \section*{%
        \texorpdfstring{% Provide clean text for PDF bookmarks
            \aufgabename~\theaufgabennr\ifstrempty{#1}{}{: #1}\ifstrempty{#2}{}{ (#2 Punkte)}%
        }{% Actual typeset heading
            {% Group for local settings
              \Large\bfseries
              \aufgabename~\theaufgabennr % "Aufgabe X" (Large, Bold)
              \ifstrempty{#1}{}{\enskip\textbf{#1}}% (Large, Bold)
              \ifstrempty{#2}{}{\hspace*{\fill}\normalfont\normalsize(#2 Punkte)}%
            }% End local group
        }% End texorpdfstring typesetting part
    }% End \section*
    \phantomsection % Add hyperref anchor
    \savename{#1}% Save name for points table
    \points{#2}% Save points for points table
    \setcounter{subaufgabe}{0} % Reset sub-task counter
    \vspace{0.5em}% Keep or adjust this space
    \noindent % Start text immediately
  }
  { % End Code
    \vspace{1.5em}% Keep or adjust this space
  }


% --- Unteraufgaben-Befehl und Formatierung ---
% (Code remains unchanged from v3.8)
\newcounter{subaufgabe}[aufgabennr]
\newcommand*\subtaskstylecommand{\alph}
\renewcommand{\thesubaufgabe}{\subtaskstylecommand{subaufgabe}}
\newcommand{\setsubtaskstyle}[1]{%
  \lowercase{\def\stylename{#1}}%
  \ifthenelse{\equal{\stylename}{numeric} \OR \equal{\stylename}{arabic}}{%
      \renewcommand*\subtaskstylecommand{\arabic}%
  }{%
    \ifthenelse{\equal{\stylename}{alpha} \OR \equal{\stylename}{alph} \OR \equal{\stylename}{alphabetic}}{%
        \renewcommand*\subtaskstylecommand{\alph}%
    }{%
        \PackageWarning{exercise_sheets}{Unbekannter Unteraufgaben-Stil '#1'. Benutze Standard (alph).}%
        \renewcommand*\subtaskstylecommand{\alph}%
    }%
  }%
}
\renewcommand{\thesubsection}{\thesubaufgabe}
\renewcommand{\subsectionformat}{\textbf{\thesubsection)}\hspace{0.5em}}
\setkomafont{subsection}{\mdseries\upshape} % Keep this for subaufgabe titles

\NewDocumentCommand{\subaufgabe}{ O{} }{%
    \refstepcounter{subaufgabe}%
    \subsection{#1} % This still uses \subsection
}


% --- Beweis-Umgebung ---
% (Code bleibt unverändert)
\theoremstyle{definition}
\newtheorem*{beweisinner}{Beweis}
\newenvironment{beweis}
  {\begin{beweisinner}}
  {\qed\end{beweisinner}}
\providecommand{\qed}{\hfill\ensuremath{\square}}

% --- Lösungs macro ---
\newcommand{\loesung}{
\vspace{12pt} 
\textit{Lösung: }}

% --- Hyperref-Setup ---
% (Code bleibt unverändert)
\hypersetup{
    colorlinks=true, linkcolor=blue, citecolor=green, urlcolor=magenta,
    pdftitle={\@modul - Übungsblatt \@blattnr}, pdfauthor={\@gruppenmitglieder},
    pdfsubject={Lösungen Übungsblatt}, pdfkeywords={LaTeX, Übungsblatt, \@modul}
}

% --- End of class file ---
\endinput