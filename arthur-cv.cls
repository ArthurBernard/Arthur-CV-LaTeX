% @Author: ArthurBernard
% @Email: arthur.bernard.92@gmail.com
% @Date: 2019-07-31 08:59:29
% @Last modified by: ArthurBernard
% @Last modified time: 2023-12-08 10:30:26
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arthur-cv}[2026/08/27 v1.0.0 Custom CV class]
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

%%==============%%
%%  Set colors  %%
%%==============%%

\definecolor{yt}{HTML}{c71610}
\definecolor{test}{HTML}{0077be}
\definecolor{linkedin}{HTML}{0085AE}

\definecolor{leftcolorband}{HTML}{E7E7E7}
\definecolor{boxcolor}{HTML}{0E5484}

\definecolor{maincolor}{HTML}{1a4c70}
\definecolor{secondcolor}{HTML}{4d4d4d}
\definecolor{thirdcolor}{HTML}{0E5484}


%%===============%%
%%  Information  %%
%%===============%%

% Declare a header field: \cv@declarefield{cvmail}{mail} creates the public
% setter \cvmail{...}, which stores its argument in \cv@mail. The storage macro
% is initialised *empty*, so simply omitting a field is exactly as safe as
% calling it with {}. Before this, an omitted field left a macro still expecting
% an argument, and the \equal test in \makeprofile then failed with an
% unreadable error -- the most likely first-run failure for a new user.
\newcommand{\cv@declarefield}[2]{%
  \expandafter\newcommand\csname cv@#2\endcsname{}%
  \expandafter\newcommand\csname #1\endcsname[1]{%
    \expandafter\renewcommand\csname cv@#2\endcsname{##1}%
  }%
}

\cv@declarefield{cvname}{name}
\cv@declarefield{cvjobtitle}{jobtitle}
\cv@declarefield{cvlinkedin}{linkedin}
\cv@declarefield{cvgithub}{github}
\cv@declarefield{cvmail}{mail}
\cv@declarefield{cvnumberphone}{numberphone}
\cv@declarefield{cvaddress}{address}
\cv@declarefield{cvsite}{site}
\cv@declarefield{cvyearsold}{yearsold}
\cv@declarefield{profilepic}{profilepic}

%%==========%%
%%  Header  %%
%%==========%%

% Set unit
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

% Set image size
\newcommand{\imsize}{\linewidth}
\newlength\imagewidth
\newlength\imagescale
\renewcommand{\imsize}{0.618\linewidth}
\pgfmathsetlength{\imagewidth}{3cm}%
\pgfmathsetlength{\imagescale}{\imagewidth/600}%

% Set header
\newcommand{\makeprofile}{
  
  % Set left color band
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, anchor=north west, fill=leftcolorband, minimum width=8cm, minimum height=27cm] at (0cm, -3.2cm) {};{};
  \end{tikzpicture}

  %-----------------------%
  % Personal informations %
  %-----------------------%

  \begin{textblock}{20.5}(0.25, 0.25)

    \begin{minipage}[t]{0.38\textwidth}

      % Set information
      \vspace{3mm}
      \renewcommand{\arraystretch}{1.4}
      \begin{tabular}{p{1.1cm} @{\hskip 0.3cm}p{6.2cm}}
        % Set phone
        \ifthenelse{\equal{\cv@numberphone}{}}{}{
          {$
            \begin{array}{l}
              \hspace{4mm} \textnormal{\LARGE \faMobile} 
            \end{array}
          $} & \large\cv@numberphone\\
        }
        % Set site
        \ifthenelse{\equal{\cv@site}{}}{}{
          {$
            \begin{array}{l}
              \hspace{2.8mm} \textnormal{\textcolor{test}{\Large \faGlobe}}
            \end{array}
          $} & \href{http://\cv@site}{\large\cv@site} \\
        }
        % Set eMail
        \ifthenelse{\equal{\cv@mail}{}}{}{
          {$
            \begin{array}{l}
              \hspace{2.5mm} \textnormal{\Large \textcolor{yt}{\faEnvelopeO}}
            \end{array}
          $} & \href{mailto:\cv@mail}{\large\cv@mail} \\
        }
        % Set LinkendIn
        \ifthenelse{\equal{\cv@linkedin}{}}{}{
          {$
            \begin{array}{l}
              \hspace{3mm} \textnormal{\Large \textcolor{linkedin}{\faLinkedin}}
            \end{array}
          $} & \href{https://www.linkedin.com\cv@linkedin}{\large\cv@linkedin} \\
        }
        % Set GitHub
        \ifthenelse{\equal{\cv@github}{}}{}{
          {$
            \begin{array}{l}
              \hspace{3mm} \textnormal{\Large \faGithub}
            \end{array}
          $} & \href{https://www.github.com/\cv@github}{\large\cv@github} \\
        }
      
      \end{tabular}

    \end{minipage}
    \begin{minipage}[t]{0.43\textwidth}

      %----------------%
      % Name and title %
      %----------------%

      % Set name and title CV
      \vspace{3mm}
      {\hspace{0mm}\Huge\color{maincolor}\cv@name}
      
      \vspace{5mm}

      {\hspace{0mm}\Large\color{secondcolor}\textbf{\cv@jobtitle}}

      \vspace{3mm}

      {\hspace{0mm}\cv@address}

      {\hspace{0mm}\cv@yearsold}

    \end{minipage}

  \end{textblock}

  %---------%
  % Picture %
  %---------%

  \begin{textblock}{3.5}(17.25, 0.25)

    % Display picture and box if provided else nothing
    \ifthenelse{\equal{\cv@profilepic}{}}{}{
      \begin{tikzpicture}[remember picture,overlay]
        \node[rectangle, anchor=north west] at (0.15cm, 0.1cm) {\includegraphics[width=\imagewidth]{\cv@profilepic}};
        \draw[line width=0.5mm, boxcolor] (0.20cm, 0.05cm) -- + (3.15cm, 0) -- + (3.15cm, -3.15cm) -- + (0,-3.15cm) -- cycle;
      \end{tikzpicture}
    }

  \end{textblock}

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
