code segment
assume cs:code
s:mov ax,0025h
  mov cl,2
  shl ax,cl

  mov ax,4ch
  int 21h
code ends
end s