" Copyright 2020 Google Inc. All rights reserved.
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.


let s:plugin = maktaba#plugin#Get('codefmt')


""
" @private
" Formatter: standard
function! codefmt#standard() abort
  let l:formatter = {
      \ 'name': 'standard',
      \ 'setup_instructions': 'Install stardard ' .
          \ 'npm -g install standard'}

  function l:formatter.IsAvailable() abort
    return executable(s:plugin.Flag('standard_executable'))
  endfunction

  function l:formatter.AppliesToBuffer() abort
    return &filetype is# 'python'
  endfunction

  ""
  " Reformat the current buffer with standard or the binary named in
  " @flag(standard_executable)
  "
  " We implement Format(), and not FormatRange{,s}(), because standard doesn't
  " provide a hook for formatting a range
  function l:formatter.Format() abort
    let l:cmd = [ s:plugin.Flag('standard_executable'), '--fix' ]
    let l:fname = expand('%:p')
    if !empty(l:fname)
      let l:cmd += ['-path', l:fname]
    endif
    call codefmt#formatterhelpers#Format(l:cmd)
  endfunction

  return l:formatter
endfunction
