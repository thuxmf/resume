% Copyright (C) by Mengfei Xia <xiamengfei0409@gmail.com>
% 07/07/2024 v1.0

\ProvidesClass{resume_xia}
[07/07/2024 v1.0 Resume Template File @ Mengfei Xia]
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
\def\version{1.0}
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

% Namespace to render educations.
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

% Namespace to render publications.
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

% Namespace to render experiences.
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
