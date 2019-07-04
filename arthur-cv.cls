\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}
\ProvidesClass{arthur-cv}[2019/06/28 Custom CV class]

%%%%%%%%%%%%%%%%%%%%%
%%  Load packages  %%
%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{ClearSans}

% \def\arrow#1{\pspicture[shift=2pt](#1,0)\psline{->}(#1,0)\endpspicture}

\usepackage{pstricks}

\usepackage{fontawesome}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}

\usepackage{enumitem}

% \setlist[itemize]{leftmargin=*}

\RequirePackage[hidelinks]{hyperref}


\RequirePackage{titlesec} % Structure
\RequirePackage{marvosym} % Icone
\RequirePackage{tikz}     % Graphic
\RequirePackage{xcolor}   % Colors
\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%
%%  Set colors  %%
%%%%%%%%%%%%%%%%%%

\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{pblue}{HTML}{0395DE}
\definecolor{yt}{HTML}{c71610}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{linkedin}{HTML}{0085AE}


%%%%%%%%%%%%%%%%%%%
%%  Information  %%
%%%%%%%%%%%%%%%%%%%

\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

\newcommand{\profilesection}[2]{{\noindent\color{black!80} \huge #1 \rule[0.15\baselineskip]{#2}{1pt} \vspace{1pt}}}

\newcommand{\skills}[1]{\renewcommand{\givenskills}{  \justifying#1}}


%%%%%%%%%%%%%%
%%  Header  %%
%%%%%%%%%%%%%%

% From opensorcerror 
\newcommand{\makeprofile}{
  \begin{tikzpicture}[remember picture,overlay]
      \node [rectangle, fill=sidecolor, anchor=north, minimum width=17cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
  \end{tikzpicture}

  %------------------------------------------------

  \begin{textblock}{36}(0.5, 0.2)

    \begin{minipage}[t]{0.33\textwidth}

    %------------------------------------------------
    
    \vspace{4mm}
    {\Huge\color{pblue}\cvname}
    
    \vspace{2mm}

    %------------------------------------------------
    
    {\Large\color{black!80}\cvjobtitle}

    %------------------------------------------------
    
    \end{minipage} 
    \hfill
    \begin{minipage}[t]{0.66\textwidth} 

    \vspace{3mm}
    \renewcommand{\arraystretch}{2}
    \begin{tabular}{p{1cm} @{\hskip 0.5cm}p{8cm}}
      \ifthenelse{\equal{\cvnumberphone}{}}{}{
      		{$
              \begin{array}{l}
              \hspace{4mm} \Large \textnormal{\faMobile} 
              \end{array}
              $} 
            & \cvnumberphone\\}
            
      \ifthenelse{\equal{\cvsite}{}}{}{
            {$
              \begin{array}{l}
              \hspace{2.8mm} \Large \textnormal{\textcolor{test}{\faGlobe}}
              \end{array}
              $} 
            & \href{http://\cvsite}{\cvsite} \\}
      \ifthenelse{\equal{\cvmail}{}}{}{
            {$
              \begin{array}{l}
              \hspace{2.5mm} \Large \textnormal{\textcolor{yt}{\faEnvelopeO}}
              \end{array}
              $} 
            & \href{mailto:\cvmail}{\cvmail} \\}
      
       \ifthenelse{\equal{\cvlinkedin}{}}{}{
            {$
              \begin{array}{l}
              \hspace{3mm} \Large \textnormal{\textcolor{linkedin}{\faLinkedin}}
              \end{array}
              $} & \href{https://www.linkedin.com\cvlinkedin}{\cvlinkedin} \\
            }  
        \ifthenelse{\equal{\cvgithub}{}}{}{
            {$
              \begin{array}{l}
              \hspace{3mm} \Large \textnormal{\faGithub}
              \end{array}
              $} & \href{https://www.github.com/\cvgithub}{\cvgithub} \\
            }   
            
    \end{tabular}

    \end{minipage} 
      
  \end{textblock}
}

%%%%%%%%%%%%%%%%%%%%%%%
%%  Left Side Block  %%
%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%
%%  Right Side Block  %%
%%%%%%%%%%%%%%%%%%%%%%%%

% \begin{minipage}[t]{0.66\textwidth}

\titleformat{\section}       % Customise the \section command 
{\Large\scshape\raggedright} % Make the \section headers large (\Large), small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}      % Can be used to give a prefix to all sections, like 'Section ...'
  {}           % Can be used to insert code before the heading
  [\titlerule] % Inserts a horizontal line after the heading

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}

\titleformat{\subsection}
  {\large\scshape\raggedright}
  {}{0em}
  {}

\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1 \hfill #2}%
}