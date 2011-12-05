let s:client_cmd = "ruby -I lib lib/outln.rb "

" show the current outln

let res = system(s:client_cmd)

put =res

