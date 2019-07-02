divert(-1) dnl  -*- mode: text -*-
dnl html.m4 -- Utility macros

changequote([,])
changecom([###])

dnl utils
define([__tr], [esyscmd([echo "$1"|tr '$2' '$3'|tr -d '\n'])])
define([__tolower], [__tr([$1],[[:upper:]],[[:lower:]])])
define([__toupper], [__tr([$1],[[:lower:]],[[:upper:]])])
define([__despace], [__tr([$1],[ '\''"],[_])])

dnl footnotes
define([__FNLSTTITLE],[Footnotes])
define([__FNLSTHLVL],[h1])
define([__fnidx], 1)
define([__fnlst],
  [<[__FNLSTHLVL]>[__FNLSTTITLE]</[__FNLSTHLVL]>])
define([__fndef],
  [define([__fnlst], __fnlst 
     <p id='fn--__fnidx'><sup>
       <a href='[#]fr--__fnidx'>__fnidx</a></sup>&nbsp;$1</p>)
   define([__fnidx],incr(__fnidx))])
define([__fnmk],
  [<a id='fr--__fnidx' href='[#]fn--__fnidx'>
    <sup>__fnidx</sup></a>__fndef($1)])

dnl sections
define([__mksectid], [__despace(__tolower($1))])
define([__nsection], [<h$1 id='__mksectid($2)'>$2</h$1>])
define([__title], [__nsection(1,$1)])
define([__section], [__nsection(2,$1)])
define([__subsection], [__nsection(3,$1)])
define([__subsubsection], [__nsection(4,$1)])

dnl emails
dnl TODO: don’t shell-out.
define([__mailprotect],[esyscmd([echo '$1'|sed 's/@/\&#x40;/'|tr -d '\n'])])

dnl links
define([__plainlink],[<a href='$1'>$1</a>])
define([__link],[<a href='$2'>$1</a>])
dnl a plain anchor.
define([__a],[<a id='$1'></a>])

dnl metadata
define([__author],[<meta  name="author" content="$1">])
define([__keywords],[<meta  name="keywords" content="$1"/>])
define([__description],[<meta  name="description" content="$1"/>])
define([__begin],[<title>$1 :: $2</title> </head> <body>])

dnl navigation
define([__crumb],
  [<div id='breadcrumbs'>
     <a href='index.html'>(top)</a>
   ifelse([index.html],__FILE__,,
     &raquo;
     <a href='__FILE__'>[$1]</a>)
   </div>
   <hr/>])

divert
