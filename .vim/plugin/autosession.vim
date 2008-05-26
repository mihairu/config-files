" Vim plugin for autosaving & autoloading session
" By: Adrian Ferrer
" Last Change: 2004 Mar 16
"
"   - Automatically works if no file is openned from command line and session
"     isn't mannualy changed (i.e. session is unattended).
"   - remembers a different session for each working directory.
"   - easy: just run Vim with no parameters, and last session will be restored.
"   - for desktops: just click on the Vim icon and you'll get your last session.


" Config
let f_auto_ses= ".vim_auto_ses"            " file for autosaved session

" if has("gui_running")                    " uncomment
"   set sessionoptions+=winpos             "   to remember
" endif                                    "   gui window position too



" Autoload last autosaved session
if v:this_session=="" && argc()==0         " if no session and no files
  if filereadable(f_auto_ses)              " if autosaved session exists
    silent exe "source" . f_auto_ses
  endif
  let v:this_session= f_auto_ses           " give name to actual session
  au VimLeave * call AutoSaveSession()     " autosave when quitting Vim
endif


" Autosave session
function! AutoSaveSession()
  if v:this_session==g:f_auto_ses && filewritable(".") " same ses & writable dir
    exe "mksession! " . g:f_auto_ses
  endif
endfunction

