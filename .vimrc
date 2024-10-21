cmap w!! w !sudo tee >/dev/null %

set mouse=a
if !has('nvim')
	set ttymouse=sgr

	"integration for wl-copy and wl-paste
	xnoremap "+y y:call system("wl-copy", @")<cr>
	nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
	nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>	
endif

set nowrap

