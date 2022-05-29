" let g:line_no_indicator_chars = [
"   \ '      ▃', '▏     ▃', '▎     ▃', '▍     ▃', '▌     ▃',
"   \ '▋     ▃', '▊     ▃', '▉     ▃', '█     ▃', '█▏    ▃',
"   \ '█▎    ▃', '█▍    ▃', '█▌    ▃', '█▋    ▃', '█▊    ▃',
"   \ '█▉    ▃', '██    ▃', '██▏   ▃', '██▎   ▃', '██▍   ▃',
"   \ '██▌   ▃', '██▋   ▃', '██▊   ▃', '██▉   ▃', '███   ▃',
"   \ '███▏  ▃', '███▎  ▃', '███▍  ▃', '███▌  ▃',
"   \ '███▋  ▃', '███▊  ▃', '███▉  ▃', '████  ▃', '████▏ ▃',
"   \ '████▎ ▃', '████▍ ▃', '████▌ ▃', '████▋ ▃', '████▊ ▃',
"   \ '████▉ ▃', '█████ ▃', '█████▏▃', '█████▎▃', '█████▍▃',
"   \ '█████▌▃', '█████▋▃', '█████▊▃', '█████▉▃', '██████▃'
"   \ ]
" let g:line_no_indicator_chars = [
"   \  ' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'
"   \  ]

" set laststatus=2
" set statusline=%=

" seperator styl
" set fillchars+=stl:═,stlnc:─,
set fillchars=stl:^,stlnc:=,horiz:-,horizup:-,horizdown:-,vert:\|,vertleft:\|,vertright:\|,verthoriz:+
set fillchars+=fold:-,foldopen:\ ,foldclose:\ ,

" hi! clear StatusLine
" hi! clear StatusLineNC
" hi! clear VertSplit
