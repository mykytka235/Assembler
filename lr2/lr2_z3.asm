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
;2)
mov ABC, ah
mov ABC+1, bh
mov ABC+2, ch
;3)
mov ax, 0h
mov al, SRC
mov DST, al
push ax
mov al, SRC+1
mov DST+1, al
push ax
mov al, SRC+2
mov DST+2, al
push ax
mov al, SRC+3
mov DST+3, al
push ax
mov al, SRC+4
mov DST+4, al
push ax
mov al, SRC+5
mov DST+5, al
push ax
mov al, SRC+6
mov DST+6, al
push ax
mov al, SRC+7
mov DST+7, al
push ax
mov ah, DST+4
lea ax, DST
push ax
pop dx
pop dx
pop dx
exit:
mov ax, 4c00h
int 21h
end start