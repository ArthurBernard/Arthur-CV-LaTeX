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
% Header shared with arthur-cv; must come after textpos and tikz, which it uses
% at load time.
\RequirePackage{arthur-cv-header}

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

%%==========%%
%%  Header  %%
%%==========%%

% Fields and header pieces come from arthur-cv-header.sty. The letter shows no
% address or age under the job title, so \cv@headerextra stays empty, and it has
% no grey band -- hence no tikz node here.
\newcommand{\makeprofile}{

  \cv@headerblock{20.25}{0.45}
  \cv@photoblock

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
