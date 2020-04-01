.model small
.stack 100h
.data
SRC DB 1, 2, 3, 4, 5, 6, 7, 8;2.2
DST DB 8 DUP (?);2.3
ABC DB 3 DUP (?);2.4
.code
start:
mov ax,@data
mov ds,ax
mov al, 12h
mov bl, 56h
mov cx, 89h
mov ah, 34h
mov bh, 78h
mov dx, 0abch
xchg ax, bx
xchg cx, dx
mov si, ax
mov di, bx
mov bp, cx
exit:
mov ax, 4c00h
int 21h
end start