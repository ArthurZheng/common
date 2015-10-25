" TAB
augroup kenotabs
	au!
" convert spaces to tabs after opening
autocmd! bufreadpost ~/TabDigital/*.{coffee,js} call ConvertToTabs()

" convert tabs to spaces before writing file
autocmd! bufwritepre ~/TabDigital/*.{coffee,js} call ConvertToSpaces()

" convert spaces to tabs after writing file
autocmd! bufwritepost ~/TabDigital/*.{coffee,js} call ConvertToTabs()
augroup END



func! ConvertToSpaces()
	let saved_view = winsaveview()
	execute 'silent %s@\v\t@  @g'
	call winrestview(saved_view)
endfunc
" Retab spaced file, but only indentation
func! ConvertToTabs()
	let saved_view = winsaveview()
	set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab

	execute 'silent %s@^\( \{'.&ts.'}\)\+@\=repeat("\t", len(submatch(0))/'.&ts.')@'
	set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
	call winrestview(saved_view)
endfunc
