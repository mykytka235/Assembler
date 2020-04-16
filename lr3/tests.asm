;b=(76x+5m) + 4d/94x + F9-4P
.model small
.stack 100H
.data
x db ?
m db ?
d db ?
f db ?
p db ?

b dw ?

.code
start:
mov ax,@data
mov ds,ax
mov x,1
mov m,2
mov d,30
mov f,1
mov p,1
; (76x+5m)
mov al,76
mul x
mov cx,ax
mov al,5
mul m
add ax,cx
mov dx,ax
;4d/94x
mov al, 94
mul x
mov cx, ax
mov al, 4
mul d
div cx
mov cx, ax
;f9-4p
mov al, 4
mul p
mov bx, ax
mov al, 9
mul f
sub ax, bx
;b=(76x+5m) + 4d/94x + F9-4P
add ax, cx
add ax, dx
mov b, ax

mov ax,4c00h
int 21H
end start
