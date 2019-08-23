% @Author: ArthurBernard
% @Email: arthur.bernard.92@gmail.com
% @Date: 2019-08-06 19:44:09
% @Last modified by: ArthurBernard
% @Last modified time: 2019-08-23 08:27:19
\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}
\ProvidesClass{arthur-cover-letter}[2019/08/06 Custom cover letter class]

% TODO : Add option several pages

%%=================%%
%%  Load packages  %%
%%=================%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{ClearSans} % Police
\usepackage{fontawesome}              % Icons
\RequirePackage{ragged2e}
\RequirePackage{parskip}
\RequirePackage[hidelinks]{hyperref}  % Hyperlink
\RequirePackage[absolute,overlay]{textpos} % Set text boxes
\RequirePackage{tikz}                 % Graphic
\RequirePackage{xcolor}               % Colors
\RequirePackage{ifthen}               % Conditions

%%==============%%
%%  Set colors  %%
%%==============%%

\definecolor{yt}{HTML}{c71610}
\definecolor{test}{HTML}{0077be}
\definecolor{linkedin}{HTML}{0085AE}

\definecolor{boxcolor}{HTML}{0E5484}

\definecolor{maincolor}{HTML}{1a4c70}
\definecolor{secondcolor}{HTML}{4d4d4d}
\definecolor{colhyperlink}{HTML}{0E5484}

%%===============%%
%%  Information  %%
%%===============%%

% Set linkedin, github, mail, phone, site, address, years old, pictures, name and tilte cv commands
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

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
  
  %-----------------------%
  % Personal informations %
  %-----------------------%

  \begin{textblock}{20.25}(0.25, 0.25)

    \begin{minipage}[t]{0.38\textwidth}

      % Set information
      \vspace{3mm}
      \renewcommand{\arraystretch}{1.4}
      \begin{tabular}{p{1.1cm} @{\hskip 0.3cm}p{6.2cm}}
        % Set phone
        \ifthenelse{\equal{\cvnumberphone}{}}{}{
          {$
            \begin{array}{l}
              \hspace{4mm} \textnormal{\LARGE \faMobile} 
            \end{array}
          $} & \large\cvnumberphone\\
        }
        % Set site
        \ifthenelse{\equal{\cvsite}{}}{}{
          {$
            \begin{array}{l}
              \hspace{2.8mm} \textnormal{\textcolor{test}{\Large \faGlobe}}
            \end{array}
          $} & \href{http://\cvsite}{\large\cvsite} \\
        }
        % Set eMail
        \ifthenelse{\equal{\cvmail}{}}{}{
          {$
            \begin{array}{l}
              \hspace{2.5mm} \textnormal{\Large \textcolor{yt}{\faEnvelopeO}}
            \end{array}
          $} & \href{mailto:\cvmail}{\large\cvmail} \\
        }
        % Set LinkendIn
        \ifthenelse{\equal{\cvlinkedin}{}}{}{
          {$
            \begin{array}{l}
              \hspace{3mm} \textnormal{\Large \textcolor{linkedin}{\faLinkedin}}
            \end{array}
          $} & \href{https://www.linkedin.com\cvlinkedin}{\large\cvlinkedin} \\
        }
        % Set GitHub
        \ifthenelse{\equal{\cvgithub}{}}{}{
          {$
            \begin{array}{l}
              \hspace{3mm} \textnormal{\Large \faGithub}
            \end{array}
          $} & \href{https://www.github.com/\cvgithub}{\large\cvgithub} \\
        }
      
      \end{tabular}

    \end{minipage}
    \begin{minipage}[t]{0.45\textwidth}

      %----------------%
      % Name and title %
      %----------------%

      % Set name and title coverletter
      \vspace{3mm}
      {\hspace{0mm}\Huge\color{maincolor}\cvname}
      
      \vspace{5mm}

      {\hspace{0mm}\Large\color{secondcolor}\textbf{\cvjobtitle}}

    \end{minipage}

  \end{textblock}

  %---------%
  % Picture %
  %---------%

  \begin{textblock}{3.5}(17.25, 0.25)

    % Display picture and box if provided else nothing
    \ifthenelse{\equal{\profilepic}{}}{}{
      \begin{tikzpicture}[remember picture,overlay]
        \node[rectangle, anchor=north west] at (0.15cm, 0.1cm) {\includegraphics[width=\imagewidth]{\profilepic}};
        \draw[line width=0.5mm, boxcolor] (0.20cm, 0.05cm) -- + (3.15cm, 0) -- + (3.15cm, -3.15cm) -- + (0,-3.15cm) -- cycle;
      \end{tikzpicture}
    }

  \end{textblock}
}

%%===================================%%
%%  Set commands and environnements  %%
%%===================================%%

%------------------%
% English commands %
%------------------%

\newcommand{\address}[1]{
  \begin{textblock}{4}(14.5, 5)
    \center #1
  \end{textblock}
}

\newcommand{\recipient}[1]{
  \begin{textblock}{4}(2.5, 7)
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
  \begin{textblock}{4}(2.5, 8)
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
\newcommand{\signing}[1]{\vspace{1cm}\hspace{12cm}#1}
\newcommand{\capit}[1]{\@capsize #1}
\newcommand{\hlink}[2]{\href{#1}{\color{colhyperlink}{\textit{#2}}}}

% Letter environnement
\newenvironment{coverletter}{%
  \begin{tikzpicture}[]
    \draw[line width=0.5mm, secondcolor] (0, 0cm) -- (16.cm, 0);
  \end{tikzpicture}
  \vspace{4.5cm}
  }{%
  \vspace{1cm}
  \begin{tikzpicture}[]
    \draw[line width=0.5mm, secondcolor] (0, 0cm) -- (16.cm, 0);
  \end{tikzpicture}
}

%%================%%
%%  Page setting  %%
%%================%%

\RequirePackage[left=2.5cm,top=3.5cm,right=2.5cm,bottom=3.cm,head=3.5cm,foot=4.cm]{geometry}
