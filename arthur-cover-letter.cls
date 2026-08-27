% @Author: ArthurBernard
% @Email: arthur.bernard.92@gmail.com
% @Date: 2019-08-06 19:44:09
% @Last modified by: ArthurBernard
% @Last modified time: 2020-01-29 19:08:37
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arthur-cover-letter}[2026/08/27 v1.1.0 Custom cover letter with header class]

%%=================%%
%%  Class options  %%
%%=================%%

% Colour themes as class options: \documentclass[green]{arthur-cover-letter}.
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

% TODO : Add option several pages

%%=================%%
%%  Load packages  %%
%%=================%%

% A class must use \RequirePackage, not \usepackage; ragged2e was loaded but
% never used.
\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{ClearSans} % Police
\RequirePackage{fontawesome}          % Icons
\RequirePackage{parskip}
\RequirePackage[hidelinks]{hyperref}  % Hyperlink
\RequirePackage[absolute,overlay]{textpos} % Set text boxes
\RequirePackage{tikz}                 % Graphic
\RequirePackage{xcolor}               % Colors
\RequirePackage{ifthen}               % Conditions

%%==============%%
%%  Set colors  %%
%%==============%%

% Icon accents. Deliberately outside the themes: the envelope reads as "mail"
% and the globe as "web" because of these colours, so they stay fixed.
\definecolor{yt}{HTML}{c71610}        % mail icon
\definecolor{test}{HTML}{0077be}      % website icon
\definecolor{linkedin}{HTML}{0085AE}  % LinkedIn brand

% The letter has no grey band and no third colour, so it uses four of the five
% theme slots. Same option names as arthur-cv, so a CV and its letter match.
% #1 box frame, #2 main, #3 second, #4 hyperlink
\newcommand{\cv@definetheme}[4]{%
  \definecolor{boxcolor}{HTML}{#1}%
  \definecolor{maincolor}{HTML}{#2}%
  \definecolor{secondcolor}{HTML}{#3}%
  \definecolor{colhyperlink}{HTML}{#4}%
}

\newcommand{\cv@theme@blue}  {\cv@definetheme{0E5484}{1a4c70}{4d4d4d}{0E5484}}
\newcommand{\cv@theme@green} {\cv@definetheme{59762f}{556b2f}{85b145}{6b8e23}}
\newcommand{\cv@theme@red}   {\cv@definetheme{851919}{420c0c}{861919}{591111}}
\newcommand{\cv@theme@grey}  {\cv@definetheme{606060}{484848}{909090}{606060}}
\newcommand{\cv@theme@yellow}{\cv@definetheme{bfa100}{5f5000}{e1b400}{7f6b00}}

\csname cv@theme@\cv@theme\endcsname

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
\cv@declarefield{cvsite}{site}
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
  
  %----------------------%
  % Personal information %
  %----------------------%

  \begin{textblock}{20.25}(0.25, 0.25)

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
    \begin{minipage}[t]{0.45\textwidth}

      %----------------%
      % Name and title %
      %----------------%

      % Set name and title letter
      \vspace{3mm}
      {\hspace{0mm}\Huge\color{maincolor}\cv@name}
      
      \vspace{5mm}

      {\hspace{0mm}\Large\color{secondcolor}\textbf{\cv@jobtitle}}

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

%%=================================%%
%%  Set commands and environments  %%
%%=================================%%

%------------------%
% English commands %
%------------------%

\newcommand{\address}[1]{
  \begin{textblock}{4}(14.5, 5)
    \center #1
  \end{textblock}
}

\newcommand{\recipient}[1]{
  \begin{textblock}{4}(2.5, 6)
    #1
  \end{textblock}
}

\newcommand{\location}[1]{
  \begin{textblock}{4}(14.5, 4.5)
    #1
  \end{textblock}
}

%-----------------%
% French commands %
%-----------------%

\newcommand{\addressfr}[1]{
  \begin{textblock}{4}(1.5, 4.5)
    \center #1
  \end{textblock}
}

\newcommand{\recipientfr}[1]{
  \begin{textblock}{4}(14.5, 5.5)
    #1
  \end{textblock}
}

\newcommand{\locationfr}[1]{
  \begin{textblock}{4}(2.5, 7)
    #1
  \end{textblock}
}

%---------------%
% Both commands %
%---------------%

\def\@capsize#1#2{\normalsize #1\small #2}

\newcommand{\subject}[1]{#1\vspace{0.5cm}}
\newcommand{\opening}[1]{#1\vspace{0.3cm}}
\newcommand{\closing}[1]{\vspace{0.3cm}#1}
\newcommand{\signing}[1]{\vspace{0.5cm}\hspace{12cm}#1}
\newcommand{\capit}[1]{\@capsize #1}
\newcommand{\hlink}[2]{\href{#1}{\color{colhyperlink}{\textit{#2}}}}

% Letter environment
\newenvironment{coverletter}{%
  \begin{tikzpicture}[]
    \draw[line width=0.5mm, secondcolor] (0, 0cm) -- (16.cm, 0);
  \end{tikzpicture}
  \vspace{3.5cm}
  }{%
  \vspace{0.5cm}
  \begin{tikzpicture}[]
    \draw[line width=0.5mm, secondcolor] (0, 0cm) -- (16.cm, 0);
  \end{tikzpicture}
}

%%================%%
%%  Page setting  %%
%%================%%

\RequirePackage[left=2.5cm,top=3.5cm,right=2.5cm,bottom=1.cm,head=3.5cm,foot=2.5cm]{geometry}
\pagenumbering{gobble}
