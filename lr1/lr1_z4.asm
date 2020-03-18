;Programm z4
.MODEL SMALL
.CODE
org 100h
begin: jmp start
r dw 34h
start: mov ax, @data
       mov ds, ax
       mov ax, 65h
       mov [r], ax
       mov si, [r]
       mov bx, 70h
       mov [r], bx
       mov di, [r]
       mov cx, 40h
       mov [r], cx
       mov bp, [r]
Exit:  mov ax, 4C00h
int 21h
END Start