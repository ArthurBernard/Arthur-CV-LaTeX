% @Author: ArthurBernard
% @Email: arthur.bernard.92@gmail.com
% @Date: 2019-08-06 19:44:09
% @Last modified by: ArthurBernard
% @Last modified time: 2019-08-09 00:48:52
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
% \RequirePackage{titlesec}             % Structure
\RequirePackage{tikz}                 % Graphic
\RequirePackage{xcolor}               % Colors

% \RequirePackage{tcolorbox}            % Colored box
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

% Set linkedin, github, mail, phone, site, address, years old, pictures, name and tilte cv commands
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
%\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
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

\newcommand{\makeprofile}{
  
  % Set left color band
  % \begin{tikzpicture}[remember picture,overlay]
  %  \node [rectangle, anchor=north west, fill=leftcolorband, minimum width=8cm, minimum height=27cm] at (0cm, -3.2cm) {};{};
  % \end{tikzpicture}

  % Set header
  \begin{textblock}{20.5}(0.25, 0.25)

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
    \begin{minipage}[t]{0.5\textwidth}

      % Set name and title CV
      \vspace{3mm}
      {\hspace{0mm}\Huge\color{maincolor}\cvname}
      
      \vspace{5mm}

      {\hspace{0mm}\Large\color{secondcolor}\textbf{\cvjobtitle}}

    \end{minipage}

  \end{textblock}

  % Display picture and box if provided else nothing
  \ifthenelse{\equal{\profilepic}{}}{}{
    \begin{tikzpicture}[remember picture,overlay]
      \node[rectangle, anchor=north west] at (17.4cm, 0.2cm) {\includegraphics[width=\imagewidth]{\profilepic}};
      \draw[line width=0.5mm, boxcolor] (17.45cm, 0.15cm) -- + (3.15cm, 0) -- + (3.15cm, -3.15cm) -- + (0,-3.15cm) -- cycle;
    \end{tikzpicture}
  }
}

%%===================================%%
%%  Set commands and environnements  %%
%%===================================%%

%------------------%
% English commands %
%------------------%

\newcommand{\address}[1]{
  \begin{textblock}{4}(15.25, 5)
    \center #1
  \end{textblock}
}

\newcommand{\recipient}[1]{
  \begin{textblock}{4}(1.75, 7)
    #1
  \end{textblock}
}

\newcommand{\location}[1]{
  \begin{textblock}{4}(15.25, 4.5)
    #1
  \end{textblock}
}

%-----------------%
% French commands %
%-----------------%

\newcommand{\addressfr}[1]{
  \begin{textblock}{4}(1., 4.5)
    \center #1
  \end{textblock}
}

\newcommand{\recipientfr}[1]{
  \begin{textblock}{4}(15.25, 5.5)
    #1
  \end{textblock}
}

\newcommand{\locationfr}[1]{
  \begin{textblock}{4}(1.75, 8)
    #1
  \end{textblock}
}

%---------------%
% Both commands %
%---------------%

\def\@capsize#1#2{\normalsize #1\small #2}

%\newcommand{\conc}[1]{\renewcommand{\conc}{#1}}
\newcommand{\subject}[1]{#1\vspace{0.5cm}}
\newcommand{\opening}[1]{#1\vspace{0.3cm}}
\newcommand{\closing}[1]{\vspace{0.3cm}#1}
\newcommand{\signing}[1]{\vspace{1cm}\hspace{12cm}#1}
\newcommand{\capit}[1]{\@capsize #1}

% Letter environnement
\newenvironment{coverletter}{%
  \begin{textblock}{17.5}(1.75, 4)
    \begin{tikzpicture}[]
      \draw[line width=0.5mm, secondcolor] (0, 0cm) -- (17.5cm, 0);
    \end{tikzpicture}
    \vspace{4.5cm}
  }{%
    \vspace{1cm}
    \begin{tikzpicture}[]
      \draw[line width=0.5mm, secondcolor] (0, 0cm) -- (17.5cm, 0);
    \end{tikzpicture}
  \end{textblock}
}

%%================%%
%%  Page setting  %%
%%================%%

\RequirePackage[left=0.cm,top=0.cm,right=0.cm,bottom=0.cm,nohead,nofoot]{geometry}
