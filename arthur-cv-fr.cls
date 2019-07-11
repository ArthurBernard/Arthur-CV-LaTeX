\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}
\ProvidesClass{arthur-cv-fr}[2019/06/28 Custom french CV class]

%%%%%%%%%%%%%%%%%%%%%
%%  Load packages  %%
%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{ClearSans} % Police
\usepackage{fontawesome}              % Icons
\RequirePackage{ragged2e}
\RequirePackage{parskip}
\RequirePackage[hidelinks]{hyperref}  % Hyperlink
\RequirePackage[absolute,overlay]{textpos} % showboxes % Set text boxes
\RequirePackage{titlesec}             % Structure
\RequirePackage{marvosym}             % Icone
\RequirePackage{tikz}                 % Graphic
\RequirePackage{xcolor}               % Colors
\RequirePackage{multirow}             % Join rows in tabular
\RequirePackage{xargs}                % Multiple optional args
\RequirePackage{tcolorbox}            % Colored box
\RequirePackage{enumitem}             % Customize item
\RequirePackage{ifthen}               % Conditions

%%%%%%%%%%%%%%%%%%
%%  Set colors  %%
%%%%%%%%%%%%%%%%%%

% TODO

\definecolor{sidecolor}{HTML}{E7E7E7}
%\definecolor{pblue}{HTML}{0395DE}
\definecolor{yt}{HTML}{c71610}
\definecolor{test}{HTML}{0077be}
\definecolor{mainblue}{HTML}{0E5484}
%\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{linkedin}{HTML}{0085AE}
\colorlet{headercolor}{gray}


%%%%%%%%%%%%%%%%%%%
%%  Information  %%
%%%%%%%%%%%%%%%%%%%

% TODO : Clean new commands

\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
% \newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand{\cvage}[1]{\renewcommand{\cvage}{#1}}

%%%%%%%%%%%%%%%%%
%%  To debugg  %%
%%%%%%%%%%%%%%%%%

%\pretolerance=1500
%\setlength{\emergencystretch}{3em}
%\overfullrule=1mm

%%%%%%%%%%%%%%
%%  Header  %%
%%%%%%%%%%%%%%

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

% TODO : Clean makeprofile command
\newcommand{\makeprofile}{
  
  % Set left color band
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, anchor=north west, fill=sidecolor, minimum width=8cm, minimum height=27cm] at (0cm, -3.2cm) {};{};
  \end{tikzpicture}

  % Set header

  \begin{textblock}{20.5}(0.25, 0.25)

    \begin{minipage}[t]{0.38\textwidth}

      % Set info

      \vspace{2mm}
      \renewcommand{\arraystretch}{1.}
      \begin{tabular}{p{1.1cm} @{\hskip 0.3cm}p{6.2cm}}
        \ifthenelse{\equal{\cvnumberphone}{}}{}{
        		{$
                \begin{array}{l}
                \hspace{4mm} \textnormal{\Large \faMobile} 
                \end{array}
                $} 
              & \cvnumberphone\\}
              
        \ifthenelse{\equal{\cvsite}{}}{}{
              {$
                \begin{array}{l}
                \hspace{2.8mm} \textnormal{\textcolor{test}{\large \faGlobe}}
               \end{array}
                $} 
              & \href{http://\cvsite}{\cvsite} \\}
        
        \ifthenelse{\equal{\cvmail}{}}{}{
              {$
                \begin{array}{l}
                \hspace{2.5mm} \textnormal{\large \textcolor{yt}{\faEnvelopeO}}
                \end{array}
                $} 
              & \href{mailto:\cvmail}{\cvmail} \\}
        
         \ifthenelse{\equal{\cvlinkedin}{}}{}{
              {$
                \begin{array}{l}
                \hspace{3mm} \textnormal{\large \textcolor{linkedin}{\faLinkedin}}
                \end{array}
                $} & \href{https://www.linkedin.com\cvlinkedin}{\cvlinkedin} \\
              }

          \ifthenelse{\equal{\cvgithub}{}}{}{
              {$
                \begin{array}{l}
                \hspace{3mm} \textnormal{\large \faGithub}
                \end{array}
              $} & \href{https://www.github.com/\cvgithub}{\cvgithub} \\
            } 

          \ifthenelse{\equal{\cvaddress}{}}{}{
            {$
              \begin{array}{l}
                \hspace{3mm} \textnormal{\large \faMapMarker}
              \end{array}
            $} & \cvaddress \\
          }

          \ifthenelse{\equal{\cvage}{}}{}{
            {$
              \begin{array}{l}
                \hspace{3mm}
              \end{array}
            $} & \cvage \\
          }
              
      \end{tabular}

    \end{minipage}
    \begin{minipage}[t]{0.5\textwidth}

      % Set name and title

      \vspace{3mm}
      {\hspace{0mm}\huge\color{mainblue}\cvname}
      
      \vspace{7mm}

      {\hspace{0mm}\Large\color{black!80}\cvjobtitle}

    \end{minipage}%

  \end{textblock}

    \begin{tikzpicture}[remember picture,overlay]%[x=\imagescale,y=-\imagescale]
      %\clip (600/2, 567/2) rectangle ; %(567/2);
      %\clip (10, 10);
      %, anchor=north east, inner sep=0pt, outer sep=0pt
      \node[rectangle, anchor=north west] at (17.4cm, 0.2cm) {\includegraphics[width=\imagewidth]{\profilepic}};
      %\node[rectangle, draw=black, anchor=north west] at (17.2cm, -0.2cm) {};
      %\draw (17.2cm, 0.2cm) -- (20.6cm, 0.2cm) -- (20.6cm, -3.2cm) -- (17.2cm, -3.2cm);
      \draw[line width=0.5mm, mainblue] (17.425cm, 0.175cm) -- + (3.2cm, 0) -- + (3.2cm, -3.2cm) -- + (0,-3.2cm) -- cycle; %+ (0,0);
    \end{tikzpicture}

}

%%%%%%%%%%%%%%%%%%%%%%%
%%  Left side block  %%
%%%%%%%%%%%%%%%%%%%%%%%

% TODO : Finish left side
\tcbuselibrary{most}
\tcbset{enhanced}

\newcommand{\sectionleft}[1]{
  \par\vspace{2mm}
  {%
    \begin{tcolorbox}[colframe=mainblue, colback=blue!10!white, shadow={0.7mm}{-1mm}{0mm}{black!50!white}, sharpish corners, boxrule=0.8mm]% , show bounding box
      \centering\LARGE\textbf{#1}
    \end{tcolorbox}
  }
  \par\vspace{1mm}
}

\newcommand{\subsectionleft}[2]{
  \par
  {%
    \begin{sloppypar}
      \begin{itemize}[label=\textbullet, font=\Large, leftmargin=7mm]
        \item \large#1 #2%
      \end{itemize}
    \end{sloppypar}
  }%\par\vspace{1mm}
}

%%%%%%%%%%%%%%%%%%%%%%%%
%%  Right side block  %%
%%%%%%%%%%%%%%%%%%%%%%%%

% Color of title section
\def\@sectioncolor#1#2#3{%
  {%
    \color{mainblue} #1#2#3%
  }%
}

% Set section
\renewcommand{\section}[1]{
  \par\vspace{1mm}
  \textbf{%
    \huge\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{1mm}
}

% Set environnement
\setlength{\tabcolsep}{2pt}
\newenvironment{rightenv}{%
  \begin{sloppypar}\begin{tabular}{@{\extracolsep{\fill}}p{2.1cm} l}
}{%
  \end{tabular}\end{sloppypar}
}

% Set item
\newcommandx{\subsectionright}[6][2= ,4= ,5= ]{%
  #1 & \parbox[t]{10.1cm}{%
    \ifblank{#2}{}{#2 en }\textbf{\large\color{mainblue}#3}%
    \hfill%
    \ifblank{#4}{}{\footnotesize à \textit{#4}}\ifblank{#5}{}{\footnotesize, #5}\\%
    \ifblank{#6}{\vspace{0mm}}{\normalsize#6\vspace{\parsep}}%
  }\\%
}

%%%%%%%%%%%%%%%%%%%%
%%  Page setting  %%
%%%%%%%%%%%%%%%%%%%%

% TODO : clean setting

\RequirePackage[left=0.cm,top=0.cm,right=0.cm,bottom=0.cm,nohead,nofoot]{geometry}
\RequirePackage{hyperref}