" autocmd BufWritePost *.py call RunPysen()
augroup formatter
  autocmd!
  autocmd BufWritePost *.py call RunBlack()
  autocmd BufWritePost *.ts,*.tsx call RunPrettier()
  autocmd BufWritePost *.tex call RunLatex()
  autocmd BufWritePost *.rs call RunRustfmt()
augroup END

" function RunPysen()
"   !pysen >/dev/null || pysen run_files format %
"   edit  " reload file
" endfunction
function RunBlack()
  !black %
  edit  " reload file
endfunction

function RunPrettier()
  !prettier -w %
  edit
endfunction

function RunLatex()
  !xelatex %
  edit
endfunction

function RunRustfmt()
  !rustfmt %
  edit
endfunction

autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
