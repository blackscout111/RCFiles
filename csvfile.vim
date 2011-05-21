" Highlight the heading
highlight def link csvHeading Type
command Csvhdr syntax match csvHeading /\%1l\%(\%("\zs\%([^"]\|""\)*\ze"\)\|\%(\zs[^,"]*\ze\)\)/
command Nocsvhdr syntax match Normal /\%1l\%(\%("\zs\%([^"]\|""\)*\ze"\)\|\%(\zs[^,"]*\ze\)\)/


" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)



" Convert csv text to columns (press u to undo).
" Warning: This deletes ',' and crops wide columns.
function! CSVTTC(cwidth)
	:let width = a:cwidth 
	:let fill = repeat(' ', width)
	:%s/"[^"]*"/\=substitute(submatch(0),',','`','g')/g
	:%s/^,/####,/g
	:%s/,$/,####/g
	:%s/,/#$$#,/g
	:%s/\([^,]*\),\=/\=strpart(submatch(1).fill, 0, width)/g
	:%s/ #$$#/ ####/g
	:%s/#$$#/    /g
	:%s/\s\+$//g
	:%s/"[^"]*"/\=substitute(submatch(0),'`',',','g')/g
endfunction
command! -nargs=1 Csvttc :call CSVTTC(<args>)



" Convert csv columns to text (press u to undo).
function! CSVCTT()
	:%s/"[^"]*"/\=substitute(submatch(0),' ','#@@#','g')/g
	:%s/ \+/,/g
	:%s/#@@#/ /g
	:%s/####//g
endfunction
command! -nargs=0 Csvctt :call CSVCTT(<args>)
