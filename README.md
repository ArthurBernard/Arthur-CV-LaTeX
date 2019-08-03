# LaTeX CV template Arthur

## Description

My customizable CV template, `arthur-cv`, let you choose color themes, display or not personnal informations (age, address or pictures) with respect to local convention, define any section on left bar (skills, etc.), and define any section (education, experiences, etc.) in the body of the CV.

## Preview

### English version

With respect to english conventions (without age, address and picture).

![English_CV](https://github.com/ArthurBernard/Arthur-CV-LaTeX/blob/master/pictures/Arthur_Bernard_CV_En.jpg)

### French version

With repect to french conventions (with picture, address and age).

![French_CV](https://github.com/ArthurBernard/Arthur-CV-LaTeX/blob/master/pictures/Arthur_Bernard_CV_Fr.jpg)

## Customized colors

You can custom themes color of the CV, see below some examples:

![Colored_Examples](https://github.com/ArthurBernard/Arthur-CV-LaTeX/blob/master/pictures/Colored_examples.jpg)

### Green

``` latex
\usepackage{xcolor}   
\definecolor{leftcolorband}{HTML}{d0f0c0}   
\definecolor{boxcolor}{HTML}{59762f}   
\definecolor{maincolor}{HTML}{556b2f}   
\definecolor{secondcolor}{HTML}{85b145}   
\definecolor{thirdcolor}{HTML}{6b8e23}   
```

### Red

``` latex
\usepackage{xcolor}   
\definecolor{leftcolorband}{HTML}{e0e0e0}   
\definecolor{boxcolor}{HTML}{851919}   
\definecolor{maincolor}{HTML}{420c0c}   
\definecolor{secondcolor}{HTML}{861919}   
\definecolor{thirdcolor}{HTML}{591111}   
```

### Grey

``` latex
\usepackage{xcolor}   
\definecolor{leftcolorband}{HTML}{e0e0e0}   
\definecolor{boxcolor}{HTML}{606060}   
\definecolor{maincolor}{HTML}{484848}   
\definecolor{secondcolor}{HTML}{909090}   
\definecolor{thirdcolor}{HTML}{606060}   
```

### Yellow

``` latex
\usepackage{xcolor}   
\definecolor{leftcolorband}{HTML}{fef2bf}%{fa8072}   
\definecolor{boxcolor}{HTML}{bfa100}%{9acd32}%{0E5484}    
\definecolor{maincolor}{HTML}{5f5000}%{1a4c70}   
\definecolor{secondcolor}{HTML}{e1b400}%{9acd32}%{4d4d4d}    
\definecolor{thirdcolor}{HTML}{7f6b00}%{0E5484}    
```

## Environment style and commands

This template is divided in three parts, header where you can define some personnal informations, left bar to display some skills and the body of your CV to display your experiences, educations, etc.

The left bar and body must be each one in a minipage environment with respectively `0.37\textwidth` and `0.61\textwidth` parameters.   
You can look one of the following examples: `example_cv.tex`, `Arthur_Bernard_CV_Fr.tex` or `Arthur_Bernard_CV_En.tex`

### Header

Set personnal informations (if you don't want to display one (or several) personnal information let the command empty):

``` latex
\profilepic{path/picture}   
\cvname{Your Name}   
\cvlinkedin{/in/your-linkedin}   
\cvgithub{YourGitHub}   
\cvmail{your.address@email.com}   
\cvnumberphone{your phone number}   
\cvaddress{Your address}   
\cvjobtitle{Title of your CV}   
\cvsite{www.your-website.com}   
\cvyearsold{your years old}   
```

### Left bar

Set section in left bar:

``` latex
\sectionleft{Title of this section}
```

Set items in left bar:

``` latex
\subsectionleft{Item name}{Optional description}
```

### Body

Set body section:

``` latex
\section{Title of this section}
```

Set items in body:

``` latex
\begin{rightenv}   
  \subsectionright{year}[1st optional argument]{title of item}[2nd optional argument][3rd optional argument]{Description of item}   
  \subsectionright{Date}[Level degree]{Title}[University][Location]{Description}   
  \subsectionright{Date}{Title job}[Firm][Location]{Description}   
\end{rightenv}   
```


## Requirements

- Compile with XeLaTex or LuaLaTeX.

- LaTeX packages:

  - fontspec;   
  - ClearSans;   
  - fontawesome;   
  - ragged2e;   
  - parskip;   
  - hyperref;   
  - textpos;   
  - titlesec;   
  - tikz;   
  - xcolor;   
  - multirow;   
  - xargs;   
  - tcolorbox;   
  - enumitem;   
  - ifthen.   

## MIT License

Copyright (c) 2019 Arthur Bernard

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
