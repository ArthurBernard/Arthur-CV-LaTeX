% @Author: ArthurBernard
% @Email: arthur.bernard.92@gmail.com
% @Date: 2019-07-31 08:59:29
% @Last modified by: ArthurBernard
% @Last modified time: 2023-12-08 10:30:26
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arthur-cv}[2026/08/27 v1.1.0 Custom CV class]

%%=================%%
%%  Class options  %%
%%=================%%

% Colour themes as class options: \documentclass[green]{arthur-cv}.
% Redefining the colours by hand in the preamble still works and still wins --
% \definecolor is last-one-wins and the user's preamble is read after the class.
% That backward-compatible route stays documented in README.md.
\newcommand{\cv@theme}{blue}
\DeclareOption{blue}{\renewcommand{\cv@theme}{blue}}
\DeclareOption{green}{\renewcommand{\cv@theme}{green}}
\DeclareOption{red}{\renewcommand{\cv@theme}{red}}
\DeclareOption{grey}{\renewcommand{\cv@theme}{grey}}
\DeclareOption{gray}{\renewcommand{\cv@theme}{grey}}
\DeclareOption{yellow}{\renewcommand{\cv@theme}{yellow}}
% Anything else (a4paper, 11pt, ...) is article's business.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass{article}

%%=================%%
%%  Load packages  %%
%%=================%%

% A class must use \RequirePackage, not \usepackage. ragged2e, titlesec and
% multirow were loaded but never used, and are dropped. etoolbox is now loaded
% explicitly: \subsectionright uses \ifblank, which until now only resolved
% through a transitive dependency of tcolorbox/xargs.
\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{ClearSans} % Police
\RequirePackage{fontawesome}          % Icons
\RequirePackage{parskip}
\RequirePackage[hidelinks]{hyperref}  % Hyperlink
\RequirePackage[absolute,overlay]{textpos} % Set text boxes
\RequirePackage{tikz}                 % Graphic
\RequirePackage{xcolor}               % Colors
\RequirePackage{xargs}                % Multiple optional args
\RequirePackage{etoolbox}             % \ifblank, used by \subsectionright
\RequirePackage{tcolorbox}            % Colored box
\RequirePackage{enumitem}             % Customize item
\RequirePackage{ifthen}               % Conditions
% Header shared with arthur-cover-letter; must come after textpos and tikz,
% which it uses at load time.
\RequirePackage{arthur-cv-header}

%%==============%%
%%  Set colors  %%
%%==============%%

% Icon accents. Deliberately outside the themes: the envelope reads as "mail"
% and the globe as "web" because of these colours, so they stay fixed.
\definecolor{yt}{HTML}{c71610}        % mail icon
\definecolor{test}{HTML}{0077be}      % website icon
\definecolor{linkedin}{HTML}{0085AE}  % LinkedIn brand

% #1 left band, #2 box frame, #3 main, #4 second, #5 third
\newcommand{\cv@definetheme}[5]{%
  \definecolor{leftcolorband}{HTML}{#1}%
  \definecolor{boxcolor}{HTML}{#2}%
  \definecolor{maincolor}{HTML}{#3}%
  \definecolor{secondcolor}{HTML}{#4}%
  \definecolor{thirdcolor}{HTML}{#5}%
}

\newcommand{\cv@theme@blue}  {\cv@definetheme{E7E7E7}{0E5484}{1a4c70}{4d4d4d}{0E5484}}
\newcommand{\cv@theme@green} {\cv@definetheme{d0f0c0}{59762f}{556b2f}{85b145}{6b8e23}}
\newcommand{\cv@theme@red}   {\cv@definetheme{e0e0e0}{851919}{420c0c}{861919}{591111}}
\newcommand{\cv@theme@grey}  {\cv@definetheme{e0e0e0}{606060}{484848}{909090}{606060}}
\newcommand{\cv@theme@yellow}{\cv@definetheme{fef2bf}{bfa100}{5f5000}{e1b400}{7f6b00}}

\csname cv@theme@\cv@theme\endcsname


%%===============%%
%%  Information  %%
%%===============%%

% The fields common to both classes are declared in arthur-cv-header.sty.
% These two are CV-only: a cover letter shows neither an address nor an age.
\cv@declarefield{cvaddress}{address}
\cv@declarefield{cvyearsold}{yearsold}

% Shown under the job title, in the header's name column.
\renewcommand{\cv@headerextra}{%
      \vspace{3mm}

      {\hspace{0mm}\cv@address}

      {\hspace{0mm}\cv@yearsold}
}

%%==========%%
%%  Header  %%
%%==========%%

\newcommand{\makeprofile}{

  % Set left color band
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, anchor=north west, fill=leftcolorband, minimum width=8cm, minimum height=27cm] at (0cm, -3.2cm) {};{};
  \end{tikzpicture}

  \cv@headerblock{20.5}{0.43}
  \cv@photoblock

}

%%===================%%
%%  Left side block  %%
%%===================%%

\tcbuselibrary{most}
\tcbset{enhanced}

% Set section at the left side
\newcommand{\sectionleft}[1]{
  \par\vspace{3.5mm}
  {%
    \begin{tcolorbox}[colframe=boxcolor, colback=boxcolor!10!white, shadow={0.7mm}{-1mm}{0mm}{black!50!white}, sharpish corners, boxrule=0.8mm]
      \centering\LARGE\textbf{#1}
    \end{tcolorbox}
  }
  \par\vspace{2mm}
}

% Set subsection left side
\newcommand{\subsectionleft}[2]{
  \par
  {%
    \begin{sloppypar}
      \begin{itemize}[label=\textbullet, font=\Large, leftmargin=7mm, parsep=0mm, itemsep=0mm, partopsep=0mm, topsep=0mm]
        \item \large#1 #2%
      \end{itemize}
    \end{sloppypar}
  }
  \par\vspace{2mm}
}

%%====================%%
%%  Right side block  %%
%%====================%%

% Color of title section
\def\@sectioncolor#1#2#3{%
  {%
    \color{maincolor} #1#2#3%
  }%
}

% Set section
\renewcommand{\section}[1]{
  \par\vspace{2.8mm}
  \textbf{%
    \huge\color{secondcolor}% #1%
    \@sectioncolor #1%
  }
  \par\vspace{1.5mm}
}

% Set environnement
\setlength{\tabcolsep}{2pt}
\newenvironment{rightenv}{%
  \begin{sloppypar}\begin{tabular}{@{\extracolsep{\fill}}p{1.6cm} l}
}{%
  \end{tabular}\end{sloppypar}
}

% Set item
\newcommandx{\subsectionright}[6][2= ,4= ,5= ]{%
  \footnotesize #1 & \parbox[t]{10.5cm}{%
    \ifblank{#2}{}{#2 }\textbf{\large\color{thirdcolor} #3}%
    \hfill%
    \ifblank{#4}{}{\textit{#4}}\ifblank{#5}{}{, \footnotesize#5}\\%
    \ifblank{#6}{\vspace{0mm}}{\normalsize#6\vspace{\parsep}}%
  }\\%
}

%%============%%
%%  New page  %%
%%============%%

\newcommand{\newcvpage}{

  \newpage

  % Set left color band
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, anchor=north west, fill=leftcolorband, minimum width=8cm, minimum height=30.5cm] at (0cm, 0.5cm) {};{};
  \end{tikzpicture}

}

%%================%%
%%  Page setting  %%
%%================%%

\RequirePackage[left=0.cm,top=0.cm,right=0.cm,bottom=0.cm,nohead,nofoot]{geometry}
