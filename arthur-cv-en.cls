\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}
\ProvidesClass{arthur-cv-en}[2019/06/28 Custom english CV class]

%%%%%%%%%%%%%%%%%%%%%
%%  Load packages  %%
%%%%%%%%%%%%%%%%%%%%%

% TODO : Clean required packages

\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{ClearSans}

\usepackage{fontawesome}

\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{pgffor}
\RequirePackage{parskip}

\usepackage{enumitem}

% \setlist[itemize]{leftmargin=*}

\RequirePackage[hidelinks]{hyperref}

\RequirePackage[absolute,overlay]{textpos} % showboxes % Set text boxes
\RequirePackage{titlesec} % Structure
\RequirePackage{marvosym} % Icone
\RequirePackage{tikz}     % Graphic
\RequirePackage{xcolor}   % Colors
\RequirePackage{multirow} % Join rows in tabular
\RequirePackage{xargs}    % Multiple optional args
\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%
%%  Set colors  %%
%%%%%%%%%%%%%%%%%%

% TODO

\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{pblue}{HTML}{0395DE}
\definecolor{yt}{HTML}{c71610}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{linkedin}{HTML}{0085AE}

\colorlet{headercolor}{gray}


%%%%%%%%%%%%%%%%%%%
%%  Information  %%
%%%%%%%%%%%%%%%%%%%

% TODO : Clean new commands

% \newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
% \newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
% \newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
% \newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

%\newcommand{\profilesection}[2]{{\noindent\color{black!80} \huge #1 \rule[0.15\baselineskip]{#2}{1pt} \vspace{1pt}}}

%\newcommand{\skills}[1]{\renewcommand{\givenskills}{  \justifying#1}}


%%%%%%%%%%%%%%
%%  Header  %%
%%%%%%%%%%%%%%

% Set unit
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

% TODO : Clean makeprofile command
\newcommand{\makeprofile}{
  
  % Set left color band
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=sidecolor, minimum width=8cm, minimum height=27cm] at (4cm, -17cm) {};
  \end{tikzpicture}
  % anchor=north, (box) at (0cm, 0cm) \paperheight

  % Set header

  \begin{textblock}{20.5}(0.25, 0.25)

    \begin{minipage}[t]{0.5\textwidth}

      % Set info

      \vspace{3mm}
      \renewcommand{\arraystretch}{1.5}
      \begin{tabular}{p{1cm} @{\hskip 0.3cm}p{8cm}}
        \ifthenelse{\equal{\cvnumberphone}{}}{}{
        		{$
                \begin{array}{l}
                \hspace{4mm} \Large \textnormal{\faMobile} 
                \end{array}
                $} 
              & \large\cvnumberphone\\}
              
        %\ifthenelse{\equal{\cvsite}{}}{}{
        %      {$
        %        \begin{array}{l}
        %        \hspace{2.8mm} \Large \textnormal{\textcolor{test}{\faGlobe}}
        %        \end{array}
        %        $} 
        %      & \href{http://\cvsite}{\cvsite} \\}
        
        \ifthenelse{\equal{\cvmail}{}}{}{
              {$
                \begin{array}{l}
                \hspace{2.5mm} \Large \textnormal{\textcolor{yt}{\faEnvelopeO}}
                \end{array}
                $} 
              & \href{mailto:\cvmail}{\large\cvmail} \\}
        
         \ifthenelse{\equal{\cvlinkedin}{}}{}{
              {$
                \begin{array}{l}
                \hspace{3mm} \Large \textnormal{\textcolor{linkedin}{\faLinkedin}}
                \end{array}
                $} & \href{https://www.linkedin.com\cvlinkedin}{\large\cvlinkedin} \\
              }

          \ifthenelse{\equal{\cvgithub}{}}{}{
              {$
                \begin{array}{l}
                \hspace{3mm} \Large \textnormal{\faGithub}
                \end{array}
              $} & \href{https://www.github.com/\cvgithub}{\large\cvgithub} \\
            }  
              
      \end{tabular}

    \end{minipage}
    \begin{minipage}[t]{0.5\textwidth}

      % Set name and title

      \vspace{3mm}
      {\Huge\color{pblue}\cvname}
      
      \vspace{7mm}

      {\Large\color{black!80}\cvjobtitle}

    \end{minipage}

  \end{textblock}

}

%%%%%%%%%%%%%%%%%%%%%%%
%%  Left side block  %%
%%%%%%%%%%%%%%%%%%%%%%%

% TODO : Finish left side

\newcommand{\sectionleft}[1]{
  \par\vspace{5mm}
  {%
    \LARGE\textbf{#1}%
  }
  \par\vspace{2mm}
}

\newcommand{\subsectionleft}[2]{
  \par
  {%
    \normalsize#1 #2%
  }
  \par\vspace{2mm}
}

%%%%%%%%%%%%%%%%%%%%%%%%
%%  Right side block  %%
%%%%%%%%%%%%%%%%%%%%%%%%

% Color of title section
\def\@sectioncolor#1#2#3{%
  {%
    \color{pblue} #1#2#3%
  }%
}

% Set section
\renewcommand{\section}[1]{
  \par\vspace{5mm}
  \textbf{%
    \LARGE\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{2mm}
}

% Set environnement
\setlength{\tabcolsep}{2pt}
\newenvironment{rightenv}{%
  \begin{tabular}{@{\extracolsep{\fill}}p{2.1cm} l}
}{%
  \end{tabular}
}

% Set item
\newcommandx{\subsectionright}[6][2= ,4= ,5= ]{%
  #1 & \parbox[t]{10.3cm}{%
    \ifblank{#2}{}{#2 in }\textbf{\color{mainblue}#3}%
    \hfill%
    \ifblank{#4}{}{\footnotesize at \textit{#4}}\ifblank{#5}{}{\footnotesize, #5}\\%
    \normalsize#6\vspace{\parsep}%
  }\\
}

%%%%%%%%%%%%%%%%%%%%
%%  Page setting  %%
%%%%%%%%%%%%%%%%%%%%

% TODO : clean setting

\RequirePackage[left=0.cm,top=0.cm,right=0.cm,bottom=0.cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}