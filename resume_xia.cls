% Copyright (C) by Mengfei Xia <xiamengfei0409@gmail.com>
% 07/07/2024 v0.1

\ProvidesClass{resume_xia}
[07/07/2024 v0.1 Resume Template File @ Mengfei Xia]
\newcommand\xia@error[1]{%
  \ClassError{resume_xia}{#1}{}%
}
\newcommand\xia@warning[1]{%
  \ClassWarning{resume_xia}{#1}%
}
\newcommand\xia@patch@error[1]{%
  \xia@error{Failed to patch command \protect#1}%
}
\NeedsTeXFormat{LaTeX2e}
\@ifl@t@r\fmtversion{2017/04/15}{}{
  \xia@error{%
    TeX Live 2017 or later version is required to compile this document%
  }
}
\def\version{0.1}
\def\xia@none{none}
\def\xia@none@zh{none}
\def\equal{equal}
\def\corresponding{corresponding}
\def\under{under}

% Global settings.
\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=xia,
  prefix=xia@,
  setkeys=\kvsetkeys
}
\newcommand\xiasetup[1]{%
  \kvsetkeys{xia}{#1}%
}
\newcommand\xia@define@key[1]{%
  \kvsetkeys{xia@key}{#1}%
}
\kv@set@family@handler{xia@key}{%
  \@namedef{xia@#1@@name}{#1}%
  \def\xia@@default{}%
  \def\xia@@choices{}%
  \kv@define@key{xia@value}{name}{%
    \@namedef{xia@#1@@name}{##1}%
  }%
  \@namedef{xia@#1@@check}{}%
  \@namedef{xia@#1@@code}{}%
  \kv@define@key{xia@value}{choices}{%
    \def\xia@@choices{##1}%
    \@namedef{xia@#1@@reset}{}%
    \@namedef{xia@#1@@check}{%
      \@ifundefined{%
        ifxia@\@nameuse{xia@#1@@name}@\@nameuse{xia@\@nameuse{xia@#1@@name}}%
      }{%
        \xia@error{Invalid value "#1 = \@nameuse{xia@\@nameuse{xia@#1@@name}}"}%
      }%
      \@nameuse{xia@#1@@reset}%
      \@nameuse{xia@\@nameuse{xia@#1@@name}@\@nameuse{xia@\@nameuse{xia@#1@@name}}true}%
    }%
  }%
  \kv@define@key{xia@value}{default}{%
    \def\xia@@default{##1}%
  }%
  \kvsetkeys{xia@value}{#2}%
  \@namedef{xia@\@nameuse{xia@#1@@name}}{}%
  \kv@set@family@handler{xia@choice}{%
    \ifx\xia@@default\@empty
      \def\xia@@default{##1}%
    \fi
    \expandafter\newif\csname ifxia@\@nameuse{xia@#1@@name}@##1\endcsname
    \expandafter\g@addto@macro\csname xia@#1@@reset\endcsname{%
      \@nameuse{xia@\@nameuse{xia@#1@@name}@##1false}%
    }%
  }%
  \kvsetkeys@expandafter{xia@choice}{\xia@@choices}%
  \expandafter\let\csname xia@\@nameuse{xia@#1@@name}\endcsname\xia@@default
  \expandafter\ifx\csname xia@\@nameuse{xia@#1@@name}\endcsname\@empty\else
    \@nameuse{xia@#1@@check}%
  \fi
  \kv@define@key{xia}{#1}{%
    \@namedef{xia@\@nameuse{xia@#1@@name}}{##1}%
    \@nameuse{xia@#1@@check}%
    \@nameuse{xia@#1@@code}%
  }%
}
\newcommand\xia@option@hook[2]{%
  \expandafter\g@addto@macro\csname xia@#1@@code\endcsname{#2}%
}
\xia@define@key{
  language = {
    name = language,
    choices = {
      chinese,
      english,
    },
    default = {english},
  },
  title-color = {
    name = title@color,
    default = {cyan},
  },
  fontset = {
    choices = {
      windows,
      mac,
      ubuntu,
      fandol,
      none,
    },
    default = none,
  },
  system = {
    choices = {
      mac,
      unix,
      windows,
      auto,
    },
    default = auto,
  },
  font = {
    choices = {
      times,
      termes,
      xits,
      libertinus,
      lm,
      auto,
      none,
    },
    default = auto,
  },
  cjk-font = {
    name = cjk@font,
    choices = {
      windows,
      mac,
      noto,
      fandol,
      auto,
      none,
    },
    default = auto,
  },
}
\xia@define@key{
  name = {
    default = {name},
  },
  name* = {
    default = {name},
    name = name@zh,
  },
  school = {
    default = {none},
  },
  school* = {
    default = {none},
    name = school@zh,
  },
  school-url = {
    default = {school-url},
    name = school@url,
  },
  department = {
    default = {none},
  },
  department* = {
    default = {none},
    name = department@zh,
  },
  department-url = {
    default = {department-url},
    name = department@url,
  },
  company = {
    default = {none},
  },
  company* = {
    default = {none},
    name = company@zh,
  },
  company-url = {
    default = {none},
    name = company@url,
  },
  phone = {
    default = {none},
  },
  email = {
    default = {email},
  },
  homepage = {
    default = {none},
  },
  googlescholar = {
    default = {none},
  },
  linkedin = {
    default = {none},
  },
}
% \DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessKeyvalOptions*
\ProcessOptions\relax
\PassOptionsToPackage{quiet}{fontspec}
% \LoadClass[a4paper]{article}
\LoadClass[a4paper,UTF8,fontset=none]{ctexart}

% Customize the packages.
\RequirePackage{geometry}
\RequirePackage{bookmark}
\RequirePackage{xeCJK}
\RequirePackage{xeCJKfntef}
\RequirePackage{fontspec}
\RequirePackage{xcolor}
\RequirePackage[T1]{fontenc}
\RequirePackage[sc,osf]{mathpazo}
\RequirePackage{sectsty}
\RequirePackage[square,sort,comma,numbers]{natbib}
\RequirePackage{setspace}
\RequirePackage{url}
% \makeatletter\let\saved@bibitem\@bibitem\makeatother
\RequirePackage{hyperref}
% \makeatletter\let\@bibitem\saved@bibitem\makeatother
\RequirePackage{threeparttable}
\RequirePackage{tabularray}

% Page setups.
\pagestyle{myheadings}
\markright{\xia@name}
\thispagestyle{empty}
\geometry{
  paper          = a4paper,  % 210 * 297mm
  top            = 3.0cm,
  left           = 2.5cm,
  right          = 2.5cm,
  marginparwidth = 1.5cm,
  marginparsep   = 0.5cm,
}
\hypersetup{%
  colorlinks     = {true},
  urlcolor       = {black},
  pdfauthor      = {\xia@name},
  pdftitle       = {\xia@name},
}
\sectionfont{\rmfamily\mdseries\Large}
\subsectionfont{\rmfamily\mdseries\itshape\large}
\setlength\parindent{0em}

% Language settings.
\ifxia@fontset@mac
  \xiasetup{
    font     = times,
    cjk-font = mac,
  }
\else
  \ifxia@fontset@windows
    \xiasetup{
      font     = times,
      cjk-font = windows,
    }
  \else
    \ifxia@fontset@fandol
      \xiasetup{
        font     = termes,
        cjk-font = fandol,
      }
    \else
      \ifxia@fontset@ubuntu
        \xiasetup{
          font     = termes,
          cjk-font = noto,
        }
      \fi
    \fi
  \fi
\fi
\ifxia@system@auto
  \IfFileExists{/System/Library/Fonts/Menlo.ttc}{
    \xiasetup{system = mac}
  }{
    \IfFileExists{/dev/null}{
      \IfFileExists{null:}{
        \xiasetup{system = windows}
      }{
        \xiasetup{system = unix}
      }
    }{
      \xiasetup{system = windows}
    }
  }
\fi
% \ifxia@font@auto
%   \ifxia@system@unix
%     \xiasetup{font=termes}
%   \else
%     \xiasetup{font=times}
%   \fi
% \fi
% \newcommand\xia@load@font@times{%
%   \setmainfont{Times New Roman}%
%   \setsansfont{Arial}%
%   \ifxia@system@mac
%     \setmonofont{Menlo}[Scale = MatchLowercase]%
%   \else
%     \setmonofont{Courier New}[Scale = MatchLowercase]%
%   \fi
% }
% \newcommand\xia@load@font@termes{%
%   \setmainfont{texgyretermes}[
%     Extension      = .otf,
%     UprightFont    = *-regular,
%     BoldFont       = *-bold,
%     ItalicFont     = *-italic,
%     BoldItalicFont = *-bolditalic,
%   ]%
%   \xia@load@texgyre@sans@mono
% }
\newcommand\xia@load@texgyre@sans@mono{%
  \setsansfont{texgyreheros}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmonofont{texgyrecursor}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Ligatures      = CommonOff,
  ]%
}
\newcommand\xia@load@font{%
  \@nameuse{xia@load@font@\xia@font}%
}
% \xia@load@font
\xia@option@hook{font}{\xia@load@font}
\ifxia@cjk@font@auto
  \ifxia@system@mac
    \xiasetup{cjk-font = mac}
  \else
    \ifxia@system@windows
      \xiasetup{cjk-font = windows}
    \else
      \IfFontExistsTF{Noto Serif CJK SC}{
        \xiasetup{cjk-font = noto}
      }{
        \xiasetup{cjk-font = fandol}
      }
    \fi
  \fi
\fi
\newcommand\xia@load@cjk@font@windows{%
  \xeCJKsetup{EmboldenFactor=2}
  \setCJKmainfont{SimSun}[
    AutoFakeBold = true,
    ItalicFont   = KaiTi,
  ]%
  \setCJKsansfont{SimHei}[AutoFakeBold]%
  \setCJKmonofont{FangSong}%
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold]%
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold]%
  \setCJKfamilyfont{zhkai}{KaiTi}%
  \setCJKfamilyfont{zhfs}{FangSong}%
}
\newcommand\xia@load@cjk@font@mac{%
  \setCJKmainfont{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = Kaiti SC,
    BoldItalicFont = Kaiti SC Bold,
  ]%
  \setCJKsansfont{Heiti SC}[BoldFont=* Medium]%
  \setCJKmonofont{STFangsong}
  \setCJKfamilyfont{zhsong}{Songti SC}[
    UprightFont = * Light,
      BoldFont  = * Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[
    UprightFont = * Light,
    BoldFont    = * Medium,
  ]%
  \setCJKfamilyfont{zhfs}{STFangsong}%
  \setCJKfamilyfont{zhkai}{Kaiti SC}[BoldFont = * Bold]%
  \setCJKfamilyfont{zhli}{Baoli SC}%
  \setCJKfamilyfont{zhyuan}{Yuanyi SC}[
    UprightFont = * Light,
    BoldFont    = * Bold,
  ]%
  \xeCJKsetwidth{‘’“”}{1em}%
}
\newcommand\xia@load@cjk@font@noto{%
  \setCJKmainfont{Noto Serif CJK SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
  ]%
  \setCJKsansfont{Noto Sans CJK SC}[
    BoldFont    = * Medium,
  ]%
  \setCJKmonofont{Noto Sans Mono CJK SC}%
  \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
    UprightFont = * Light,
    UprightFont = * Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
    BoldFont    = * Medium,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
}
\newcommand\xia@load@cjk@font@fandol{%
  \setCJKmainfont{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
    ItalicFont  = FandolKai-Regular,
  ]%
  \setCJKsansfont{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKmonofont{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhsong}{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhhei}{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
}
\ifxia@cjk@font@none\else
  \providecommand\songti{\CJKfamily{zhsong}}
  \providecommand\heiti{\CJKfamily{zhhei}}
  \providecommand\fangsong{\CJKfamily{zhfs}}
  \providecommand\kaishu{\CJKfamily{zhkai}}
\fi
\newcommand\xia@load@cjk@font{%
  \@nameuse{xia@load@cjk@font@\xia@cjk@font}%
}
\xia@load@cjk@font
\xia@option@hook{cjk-font}{\xia@load@cjk@font}
\newcommand\xia@set@names{%
  \ifxia@language@english
    \def\xia@resume@education{Education}
    \def\xia@resume@publication{Publications}
    \def\xia@resume@experience{Experiences}
    \def\xia@resume@phone{Phone}
    \def\xia@resume@email{Email}
    \def\xia@resume@homepage{Homepage}
    \def\xia@resume@googlescholar{Google Scholar}
    \def\xia@resume@linkedin{LinkedIn}
  \else
    \def\xia@resume@education{教育经历}
    \def\xia@resume@publication{发表文章}
    \def\xia@resume@experience{经历}
    \def\xia@resume@phone{电话}
    \def\xia@resume@email{邮箱}
    \def\xia@resume@homepage{主页}
    \def\xia@resume@googlescholar{谷歌学术}
    \def\xia@resume@linkedin{领英}
  \fi
}
\xia@set@names
\xia@option@hook{language}{\xia@set@names}

\newcommand{\info}{%
\ifxia@language@english
  \ifx\xia@company\xia@none
    {\Huge \xia@name} ({\large \href{\xia@department@url}{\xia@department} @ \href{\xia@school@url}{\xia@school}})
  \else
    {\Huge \xia@name} ({\large \href{\xia@company@url}{\xia@company}})
  \fi
\else
  \ifx\xia@company@zh\xia@none
    {\Huge \xia@name@zh} ({\large \href{\xia@department@url}{\xia@department@zh} @ \href{\xia@school@url}{\xia@school@zh}})
  \else
    {\Huge \xia@name@zh} ({\large \href{\xia@company@url}{\xia@company@zh}})
  \fi
\fi
\par
\vspace{0.45in}
\renewcommand\arraystretch{1.2}
\setlength{\tabcolsep}{10.0pt}
\begin{tabular}{ll}
  \xia@resume@phone : & \xia@phone \\
  \xia@resume@email : & \href{mailto:\xia@email}{\tt \xia@email} \\
  \ifx\xia@homepage\xia@none
  \else
    \xia@resume@homepage : & \href{\xia@homepage}{\tt \xia@homepage} \\
  \fi
  \ifx\xia@googlescholar\xia@none
  \else
    \xia@resume@googlescholar : & \href{\xia@googlescholar}{\tt \xia@googlescholar} \\
  \fi
  \ifx\xia@linkedin\xia@none
  \else
    \xia@resume@linkedin : & \href{\xia@linkedin}{\tt \xia@linkedin} \\
  \fi
\end{tabular}
\vspace{2.0\baselineskip}
}
\newenvironment{education}{
  \section*{\color{\xia@title@color}\xia@resume@education}
  \ifxia@language@english
    \vspace{-1.5\baselineskip}
  \else
    \vspace{-1.35\baselineskip}
  \fi
  \noindent\hrulefill
  \vspace{-0.3\baselineskip}
  \par
}{%
  \par
  \vspace{1.6\baselineskip}
}
\newenvironment{publication}{
  \section*{\color{\xia@title@color}\xia@resume@publication}
  \ifxia@language@english
    \vspace{-1.5\baselineskip}
  \else
    \vspace{-1.35\baselineskip}
  \fi
  \noindent\hrulefill
  \par
  \ifxia@language@english
    $^*$ equal contribution\quad$^\dag$ corresponding author
  \else
    $^*$ 共一\quad$^\dag$ 通讯作者
  \fi
  \par
  \vspace{-0.3\baselineskip}
}{%
  \par
  \vspace{2.0\baselineskip}
}
\newenvironment{experience}{
  \section*{\color{\xia@title@color}\xia@resume@experience}
  \ifxia@language@english
    \vspace{-1.5\baselineskip}
  \else
    \vspace{-1.35\baselineskip}
  \fi
  \noindent\hrulefill
  \vspace{-0.6\baselineskip}
  \par
}{%
  \par
}
\newenvironment{customitemize}{
  \begin{list}{}{
    \setlength{\leftmargin}{.5em}
  }
}{
  \end{list}
}

% Render educations.
\xia@define@key{
  edu-school = {
    default = {none},
    name = edu@school,
  },
  edu-school* = {
    default = {none},
    name = edu@school@zh,
  },
  edu-time = {
    default = {none},
    name = edu@time,
  },
  edu-time* = {
    default = {none},
    name = edu@time@zh,
  },
  edu-location = {
    default = {none},
    name = edu@location,
  },
  edu-location* = {
    default = {none},
    name = edu@location@zh,
  },
  edu-intro = {
    default = {none},
    name = edu@intro,
  },
  edu-intro* = {
    default = {none},
    name = edu@intro@zh,
  },
  edu-detail = {
    default = {none},
    name = edu@detail,
  },
  edu-detail* = {
    default = {none},
    name = edu@detail@zh,
  },
}
\newcommand\xia@empty@education{
  \xiasetup{
    edu-school = {none},
    edu-school* = {none},
    edu-time = {none},
    edu-time* = {none},
    edu-location = {none},
    edu-location* = {none},
    edu-intro = {none},
    edu-intro* = {none},
    edu-detail = {none},
    edu-detail* = {none},
  }
}
\newcommand\rendereducation{
  \ifxia@language@english
    \def\xia@edu@spacing{0.95}
  \else
    \def\xia@edu@spacing{1.05}
  \fi
  \begin{spacing}{\xia@edu@spacing}
  \ifxia@language@english
    \ifx\xia@edu@school\xia@none
    \else
    \begin{customitemize}
      \item \textbf{\xia@edu@school \hfill{\xia@edu@location}}
      \par
      \emph{\xia@edu@intro\hfill{\xia@edu@time}}
      \par
      \ifx\xia@edu@detail@zh\xia@none
      \else
        {\small\textcolor{gray}{\xia@edu@detail}}
        \par
      \fi
    \end{customitemize}
    \fi
  \else
    \ifx\xia@edu@school@zh\xia@none
    \else
    \begin{customitemize}
      \item \textbf{\xia@edu@school@zh \hfill{\xia@edu@location@zh}}
      \par
      \emph{\xia@edu@intro@zh\hfill{\xia@edu@time@zh}}
      \par
      \ifx\xia@edu@detail@zh\xia@none
      \else
        {\small\textcolor{gray}{\xia@edu@detail@zh}}
        \par
      \fi
    \end{customitemize}
    \fi
  \fi
  \end{spacing}
  \vspace{-0.1in}
  \xia@empty@education
}

% Render publications.
\xia@define@key{
  pub-title = {
    default = {none},
    name = pub@title,
  },
  pub-status = {
    default = {none},
    name = pub@status,
    choices = {
      under,
      none,
    }
  },
  pub-location = {
    default = {none},
    name = pub@location,
  },
  pub-author-a = {
    default = {none},
    name = pub@author@a,
  },
  pub-contrib-a = {
    default = {none},
    name = pub@contrib@a,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-b = {
    default = {none},
    name = pub@author@b,
  },
  pub-contrib-b = {
    default = {none},
    name = pub@contrib@b,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-c = {
    default = {none},
    name = pub@author@c,
  },
  pub-contrib-c = {
    default = {none},
    name = pub@contrib@c,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-d = {
    default = {none},
    name = pub@author@d,
  },
  pub-contrib-d = {
    default = {none},
    name = pub@contrib@d,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-e = {
    default = {none},
    name = pub@author@e,
  },
  pub-contrib-e = {
    default = {none},
    name = pub@contrib@e,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-f = {
    default = {none},
    name = pub@author@f,
  },
  pub-contrib-f = {
    default = {none},
    name = pub@contrib@f,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-g = {
    default = {none},
    name = pub@author@g,
  },
  pub-contrib-g = {
    default = {none},
    name = pub@contrib@g,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-h = {
    default = {none},
    name = pub@author@h,
  },
  pub-contrib-h = {
    default = {none},
    name = pub@contrib@h,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-i = {
    default = {none},
    name = pub@author@i,
  },
  pub-contrib-i = {
    default = {none},
    name = pub@contrib@i,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
  pub-author-j = {
    default = {none},
    name = pub@author@j,
  },
  pub-contrib-j = {
    default = {none},
    name = pub@contrib@j,
    choices = {
      equal,
      corresponding,
      none,
    }
  },
}
\newcommand\xia@empty@publication{
  \xiasetup{
    pub-title     = {none},
    pub-location  = {none},
    pub-status    = {none},
    pub-author-a  = {none},
    pub-contrib-a = {none},
    pub-author-b  = {none},
    pub-contrib-b = {none},
    pub-author-c  = {none},
    pub-contrib-c = {none},
    pub-author-d  = {none},
    pub-contrib-d = {none},
    pub-author-e  = {none},
    pub-contrib-e = {none},
    pub-author-f  = {none},
    pub-contrib-f = {none},
    pub-author-g  = {none},
    pub-contrib-g = {none},
    pub-author-h  = {none},
    pub-contrib-h = {none},
    pub-author-i  = {none},
    pub-contrib-i = {none},
    pub-author-j  = {none},
    pub-contrib-j = {none},
  }
}
\newcommand\xia@contrib[1]{
  \ifx#1\xia@none
    \hskip -5pt
  \else
    \ifx#1\equal
      \hskip -2pt$^*$\hskip -3pt
    \else
      \hskip -2pt$^\dag$\hskip -3pt
    \fi
  \fi
}
\newcommand\xia@status[1]{
  \ifx#1\xia@none
  \else
    \ifxia@language@english
      (under review)
    \else
      （在投）
    \fi
  \fi
}
\newcommand\xia@render@pub@firstauthor[2]{
  \ifx#1\xia@none
  \else
    \ifx#1\xia@name
      \hskip -4pt\textbf{\textcolor{black}{#1}\xia@contrib{#2}}
    \else
      \hskip -4pt\textcolor{gray}{#1\xia@contrib{#2}}
    \fi
  \fi
}
\newcommand\xia@render@pub@author[2]{
  \ifx#1\xia@none
  \else
    \ifx#1\xia@name
      \hskip -4pt\textbf{\textcolor{gray}{, }\textcolor{black}{#1}\xia@contrib{#2}}
    \else
      \hskip -4pt\textcolor{gray}{, #1\xia@contrib{#2}}
    \fi
  \fi
}
\newcommand\renderpublication{
  \ifx\xia@pub@title\xia@none
  \else
  \begin{customitemize}
    \item {\small\textbf{\xia@pub@title}\hfill{\textbf{\xia@pub@location}\xia@status{\xia@pub@status}}}
    \vspace{-0.04in}
    \par
    \footnotesize\emph{
      \xia@render@pub@firstauthor{\xia@pub@author@a}{\xia@pub@contrib@a}
      \xia@render@pub@author{\xia@pub@author@b}{\xia@pub@contrib@b}
      \xia@render@pub@author{\xia@pub@author@c}{\xia@pub@contrib@c}
      \xia@render@pub@author{\xia@pub@author@d}{\xia@pub@contrib@d}
      \xia@render@pub@author{\xia@pub@author@e}{\xia@pub@contrib@e}
      \xia@render@pub@author{\xia@pub@author@f}{\xia@pub@contrib@f}
      \xia@render@pub@author{\xia@pub@author@g}{\xia@pub@contrib@g}
      \xia@render@pub@author{\xia@pub@author@h}{\xia@pub@contrib@h}
      \xia@render@pub@author{\xia@pub@author@i}{\xia@pub@contrib@i}
      \xia@render@pub@author{\xia@pub@author@j}{\xia@pub@contrib@j}
    }
  \end{customitemize}
  \vspace{-0.25in}
  \xia@empty@publication
  \fi
}

% Render experiences.
\xia@define@key{
  exp = {
    default = {none},
  },
  exp* = {
    default = {none},
    name = exp@zh,
  },
  exp-type = {
    default = {none},
    name = exp@type,
  },
  exp-type* = {
    default = {none},
    name = exp@type@zh,
  },
  exp-intro = {
    default = {none},
    name = exp@intro,
  },
  exp-intro* = {
    default = {none},
    name = exp@intro@zh,
  },
  exp-time = {
    default = {none},
    name = exp@time,
  },
  exp-time* = {
    default = {none},
    name = exp@time@zh,
  },
}
\newcommand\xia@empty@experience{
  \xiasetup{
    exp = {none},
    exp* = {none},
    exp-type = {none},
    exp-type* = {none},
    exp-intro = {none},
    exp-intro* = {none},
    exp-time = {none},
    exp-time* = {none},
  }
}
\newcommand\renderexperience{
  \ifx\xia@exp@time@zh\xia@none
    \let\xia@exp@time@zh\xia@exp@time
  \fi
  \ifxia@language@english
    \ifx\xia@exp\xia@none
    \else
    \begin{customitemize}
      \item \textbf{\xia@exp}, \xia@exp@type\hfill{\emph{\xia@exp@time}}
      \par
      \ifx\xia@exp@intro\xia@none
      \else
        \vspace{-0.08in}
        {\small\textcolor{gray}{\xia@exp@intro}}
        \par
      \fi
    \end{customitemize}
    \fi
  \else
    \ifx\xia@exp@zh\xia@none
    \else
    \begin{customitemize}
      \item \textbf{\xia@exp@zh}，\xia@exp@type@zh\hfill{\emph{\xia@exp@time@zh}}
      \par
      \ifx\xia@exp@intro@zh\xia@none
      \else
        \vspace{-0.08in}
        {\small\textcolor{gray}{\xia@exp@intro@zh}}
        \par
      \fi
    \end{customitemize}
    \fi
  \fi
  \xia@empty@experience
  \vspace{-0.2in}
}
