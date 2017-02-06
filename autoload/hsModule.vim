function! s:Split(path)
  if has("win32")
    return split(a:path, '[\/]\+')
  else
    return split(a:path, '/\+')
  endif
endfunction

function! s:CapitalizedSuffix(ps)
  let result=[]
  for p in reverse(a:ps)
    if p =~# '^[[:upper:]]'
      let result=[p]+result
    else
      break
    endif
  endfor
  return result
endfunction

function! s:ModuleName()
  let ps=s:CapitalizedSuffix(s:Split(expand('%:p')))
  let n=len(ps)
  if n==0
    return ''
  else
    " strip the extension of the last component
    let ps[n-1]=fnamemodify(ps[n-1], ":r:t")
    return join(ps,'.')
  endif
endfunction

function! hsModule#MkModuleHeader()
  let name=s:ModuleName()
  if !empty(name)
    return "module " . name . "\n     () where\n"
  else
    return ''
  endif
endfunction
