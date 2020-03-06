code segment
assume cs:code
s:mov ax,10
  mov bx,9
  mov cx,8
  mov dx,7
  mov sp,6
  mov bp,5
  mov si,4
  mov di,3
  mov ds,2
  mov es,1

  mov ax,4ch
  int 21h
code ends
end s

