func! AutoBuild()
	augroup autobuild
		au!
		au BufWritePost *.coffee make
		au BufWritePost *.ts make
		au BufWritePost *.less make
		au BufWritePost *.yml make
	augroup END
endfunction

func! NoAutoBuild()
	augroup autobuild
		au!
	augroup END
endfunction

command! AutoBuild call AutoBuild()
command! NoAutoBuild call NoAutoBuild()
