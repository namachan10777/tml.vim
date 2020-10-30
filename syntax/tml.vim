if version >= 600
	if exists("b:current_syntax")
		finish
	end
end

setlocal iskeyword=a-z,A-Z,-,48-57
syn case match

syn region tmlComment start="%" end="$" contains=tmlCommentTodo,@Spell
syn keyword tmlCommentTodo contained TODO FIXME XXX NB NOTE

syn region tmlInlineLiteralString contained start="`" skip="\\`" end="`"

syn match tmlNumber contained "\d\+\>" nextgroup=@tmlArguments
syn match tmlFloat  contained "\d\+e[-+]\=\d\+\>" nextgroup=@tmlArguments
syn region tmlString contained start="\"" skip="\\\"" end="\"" nextgroup=@tmlArguments
syn region tmlLiteral contained start="###`" end="`###" nextgroup=@tmlArguments
syn cluster tmlTextElem contains=tmlComment,tmlInlineLiteralString
syn cluster tmlValues contains=tmlString,tmlNumber,tmlFloat,tmlLiteral
syn match tmlArgument "[a-zA-Z][-a-zA-Z0-9][ \\t\\n\\r]*=" contains=tmlValues skipwhite skipempty nextgroup=@tmlValues

syn match tmlCommand "\\[a-zA-Z][-a-zA-Z0-9]*" contains=tmlNumber,tmlFloat,tmlString,tmlLiteral nextgroup=@tmlArguments skipwhite skipempty

syn cluster tmlCmdLasts contains=tmlArgument,tmlText,tmlCmds

syn region tmlText contained matchgroup=tmlKeyword start="{" matchgroup=tmlKeyword end="}" skipwhite skipempty nextgroup=@tmlCmdEnd
syn region tmlCmds contained matchgroup=tmlKeyword start="\[" matchgroup=tmlKeyword end="\]" skipwhite skipempty nextgroup=@tmlCmdEnd
syn match tmlSemicolon ";"
syn cluster tmlCmdEnd contains=tmlSemicolon

hi def link tmlInlineLiteralString String
hi def link tmlString String
hi def link tmlLiteral String
hi def link tmlNumber Number
hi def link tmlFloat Number
hi def link tmlCommand Identifier
