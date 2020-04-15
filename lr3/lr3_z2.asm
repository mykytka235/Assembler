;Q = 4D + 2A*(3T-C)+(A-B*D)/P
.model small
.stack 100H
.data
A db ?
B db ?
C db ?
D db ?
P db ?
T db ?

Q dw ?

.code
start:
mov ax,@data
mov ds,ax
mov A,11
mov B,2
mov C,2
mov D,5
mov P,5
mov T,2
; (A-B*D)/P
mov al,B
mul D
mov cx,ax
mov al,A
sub ax,cx
mov cl,P
div cl
mov dx,ax
;4*D
mov al, 4
mul D
mov cx, ax
;2A*(3T-C)
mov al, 3
mul T
sub ax, cx
mul A
mov bx, ax
mov al, 2
mul bx
;Q = 4D + 2A*(3T-C)+(A-B*D)/P
add ax, cx
add ax, dx

aam

mov ax,4c00h
int 21H
end start