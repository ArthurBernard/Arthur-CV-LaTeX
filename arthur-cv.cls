\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}
\ProvidesClass{arthur-cv}[2019/06/28 Custom CV class]

%%%%%%%%%%%%%%%%%%%%%
%%  Load packages  %%
%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{ClearSans}

% \def\arrow#1{\pspicture[shift=2pt](#1,0)\psline{->}(#1,0)\endpspicture}

% \usepackage{pstricks}

\usepackage{fontawesome}

\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay,showboxes]{textpos}
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

\colorlet{headercolor}{gray}


%%%%%%%%%%%%%%%%%%%
%%  Information  %%
%%%%%%%%%%%%%%%%%%%

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

% From opensorcerror 
\newcommand{\makeprofile}{
  \begin{tikzpicture}%[remember picture,overlay]
    \node [rectangle, fill=sidecolor, anchor=north, minimum width=8cm, minimum height=\paperheight] (box) at (0cm, -5cm){};
  \end{tikzpicture}

  %------------------------------------------------

  \begin{textblock}{20.5}(0.25, 0.2)

    \begin{minipage}[t]{0.5\textwidth}

      \vspace{3mm}
      \renewcommand{\arraystretch}{1.5}
      \begin{tabular}{p{1cm} @{\hskip 0.5cm}p{8cm}}
        \ifthenelse{\equal{\cvnumberphone}{}}{}{
        		{$
                \begin{array}{l}
                \hspace{4mm} \Large \textnormal{\faMobile} 
                \end{array}
                $} 
              & \cvnumberphone\\}
              
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
    \begin{minipage}[t]{0.5\textwidth}

      \vspace{3mm}
      {\Huge\color{pblue}\cvname}
      
      \vspace{7mm}

      {\Large\color{black!80}\cvjobtitle}

    \end{minipage}

  \end{textblock}

}

%%%%%%%%%%%%%%%%%%%%%%%
%%  Left Side Block  %%
%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%
%%  Right Side Block  %%
%%%%%%%%%%%%%%%%%%%%%%%%

\def\@sectioncolor#1#2#3{%
  {%
    \color{pblue} #1#2#3%
  }%
}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{1mm}
}

\titleformat{\section}       % Customise the \section command 
{\Large\scshape\raggedright} % Make the \section headers large (\Large), small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}      % Can be used to give a prefix to all sections, like 'Section ...'
  {}           % Can be used to insert code before the heading
  [\titlerule] % Inserts a horizontal line after the heading

\newcommand{\sectionleft}[1]{
  \par\vspace{\parskip}
  {%
    \Large\textbf{#1}%
  }
  \par\vspace{1mm}
}

\newcommand{\subsectionleft}[2]{
  \par
  {%
    \normalsize#1 #2%
  }\\
}

\titleformat{\subsection}
  {\large\scshape\raggedright}%
  {}{0em}%
  {}%

\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1 \hfill #2}%
}

%%%%%%%%%%%%%%%
%%  Exp env  %%
%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{expenv}{%
  \begin{tabular*}{0.5\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}

\newcommand{\expitem}[6]{%
  #1&\parbox[t]{10.5cm}{%
    \textbf{\color{pblue}#3}%
    \hfill%
    {\footnotesize at \textit{#4}, #5}%\\
    %#4\vspace{\parsep}%
  }\\
  #2&\parbox[t]{10.5cm}{%
    #6 \\
  }\\
}

%%%%%%%%%%%%%%%
%%  Exp env  %%
%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{eduenv}{%
  \begin{tabular*}{0.5\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
}

\newcommand{\eduitem}[6]{%
  #1&\parbox[t]{10.5cm}{%
    #2 in \textbf{\color{pblue}#3}%
    \hfill%
    {\footnotesize at \textit{#4}, #5}\\%
    #6\vspace{\parsep}%
  }\\
}

\newcommand{\twentyitem}[6]{%
  #1&\parbox[t]{0.83\textwidth}{%
    \textbf{#3}% 
    \hfill%
    {\footnotesize#4}%
        }\\%
    #2&\parbox[t]{0.83\textwidth}{%
    \ifblank{#5}{}{#5 \\}
    #6%
  }\\
}

%%%%%%%%%%%%%%%%%%%%
%%  Page setting  %%
%%%%%%%%%%%%%%%%%%%%

\RequirePackage[left=0.cm,top=0.cm,right=0.cm,bottom=0.cm,nohead,nofoot]{geometry}
% \RequirePackage{hyperref}