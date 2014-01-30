" Make IEEEeqnarray get math highlighting.
command -nargs=+ HiLink hi def link <args>
call TexNewMathZone("M", "IEEEeqnarray", 1)
delcommand HiLink

" Make \citeN and \citeNP be highlighted as citations.
syn match  texRefZone '\\cite\(NP\=\|gen\)' nextgroup=texRefOption,texCite
