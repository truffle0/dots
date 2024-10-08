cmap w!! w !sudo tee >/dev/null %

set mouse=a
if !has('nvim')
	set ttymouse=sgr

	"integration for wl-copy and wl-paste
	xnoremap "+y y:call system("wl-copy", @")<cr>
	xnoremap "*y y:call system("wl-copy --primary", @")<cr>
	xnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
	xnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>, '', 'g')<cr>p
endif

set nowrap

