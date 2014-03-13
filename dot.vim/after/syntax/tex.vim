" Make IEEEeqnarray get math highlighting.
command -nargs=+ HiLink hi def link <args>
call TexNewMathZone("M", "IEEEeqnarray", 1)
delcommand HiLink

" Make \citeN and \citeNP be highlighted as citations. PCRE regex: /\\cite(NP?|gen)/
syn match  texRefZone '\\cite\(NP\=\|gen\)' nextgroup=texRefOption,texCite
" Make \Cite* highlight as citations too. PCRE regex: /\\Cite(NP?|gen)?/
syn match  texRefZone '\\Cite\(NP\=\|gen\)\=' nextgroup=texRefOption,texCite
" Make \newcite highlight as citations too. PCRE Regex: /\\newcite/
syn match  texRefZone '\\newcite' nextgroup=texRefOption,texCite
