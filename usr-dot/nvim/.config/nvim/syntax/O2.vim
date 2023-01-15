if exists("b:current_syntax")
    finish
endif

if !exists("o2_upper_case")
  syntax case ignore
else
  " use :let o2_upper_case=1
  syntax case match
endif

": help usr_44
":h sys-pattern

" syntax conceal on
" setlocal iskeyword+=-

syntax match O2Variables "\v\h+\w*"

syntax keyword O2Keyword NAME PROJ
syntax keyword O2Keyword INTWL PASSE
syntax keyword O2Keyword WL SYS ABD ACC WO NOIMAGE
syntax keyword O2Keyword FARBGEW FREL FWGT HEP HS VT SO IM DFC SSOS HAP
syntax keyword O2Keyword RA TR TILT DONUT OVAL ROLL MC PROC FCT
syntax keyword O2Keyword COR
syntax keyword O2Keyword CHANGE C
syntax keyword O2Keyword MOVE
syntax keyword O2Keyword TFMS WLBM VIG
syntax keyword O2Keyword GAP RAY RAYG

syntax match O2Operators "[+-/*%^]"

syntax keyword O2NativeVars WORKSHEET PARAX
syntax keyword O2NativeVars ABD BETAP ABSFIELD NFL

syntax keyword O2Function WRITE VERBOSE 
syntax keyword O2Type DOUBLE STRING

syntax keyword O2Statment FUNCTION PROCEDURE STRUCT END RETURN
syntax keyword O2Block RLE ENDLENS 
syntax keyword O2Block PLOT SHAPE RABER
syntax keyword O2Block FL ZFR DEC VARIO GLAS 
syntax keyword O2Block ABER RIM
syntax keyword O2Block RTOL DEFORM COMP ANALYSE USERSPEC
syntax keyword O2Block TRA

syntax keyword O2Conditional IF OR ELSE THEN UNTIL SELECT CASE OTHERWISE
syn keyword O2Repeat FOR TO DO BY WHILE REPEAT LOOP CONTINUE STOP

syntax match O2Comment "\v^\s*\*.*$"
syntax match O2Comment "\v//.*$"
syntax region O2Comment start="\v/\*" end="\v\*/\@="


syntax match O2Number "\v<-?\.?\d+\.?\d*([eEdD][-+]?\d+)?>"
syntax keyword O2Number INFINITE

syntax match O2Tabs "\v\t+"

syntax region O2String start=+"+  skip=+\\"+  end=+"+ oneline
syntax region O2String start=+'+  skip=+\\'+  end=+'+ oneline

highlight link O2Keyword      Keyword
highlight link O2Function     Function
highlight link O2NativeVars   Constant
highlight link O2NV           Constant
" --- highlight link O2NativeVars   SpecialKey
highlight link O2Type         Type
highlight link O2Statment     Statement
highlight link O2Block        Statement
highlight link O2Comment      Comment
highlight link O2Number       Number
highlight link O2Conditional  Conditional
highlight link O2Repeat       Conditional
highlight link O2Tabs         TabLine
highlight link O2Variables    Variable
highlight link O2String       String

let b:current_syntax = "O2"
