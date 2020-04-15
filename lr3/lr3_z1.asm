;Q = (A-B*D)/P
.model SMALL
.stack 100H
.data
A db ?
B db ?
D db ?
P db ?
Q dw ?

.code
start:
mov ax,@DATA
mov ds,ax
mov A,99h
mov B,9h
mov D,2h
mov P,5h

mov al,B
mul D
mov cx,ax
mov al,A
sub ax,cx

mov cl,P
div cl
mov Q,AX
aam

mov ax,4c00h
int 21H
end start