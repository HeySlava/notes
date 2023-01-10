[Examples, move, remove, settings](https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/)


```bash
# As branches
let g:netrw_liststyle = 3
```


```bash
# Remove banner
let g:netrw_banner = 0
```

```bash
# Open new file vertically on the right
let g:netrw_browse_split = 1
```

```bash
Open preview vertically
let g:netrw_preview = 1
```


```bash
# From help
# An interesting set of netrw settings is:  
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 30
```

```bash
# Leader dd: Will open Netrw in the directory of the current file.
# Leader da: Will open Netrw in the current working directory.
nnoremap <leader>dd :Lexplore %:p:h<CR>
nnoremap <Leader>da :Lexplore<CR>
```


[Cheetshet](https://gist.github.com/danidiaz/37a69305e2ed3319bfff9631175c5d0f)
