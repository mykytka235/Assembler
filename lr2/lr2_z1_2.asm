.model small
.code 
org 100h 
string DW 0abch
Start: 
;1
mov al, 12h
mov bl, 56h
mov cx, 89h
mov ah, 34h
mov bh, 78h
mov dx, [string]
;2
xchg ax, bx
xchg cx, dx
;3
mov si, ax
mov di, bx
mov bp, cx
int 21h
exit:
mov ax, 4c00h
int 21h
END Start 