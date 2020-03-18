; Programm z2
.model small 
.stack 100h 
.data 
Hello DB 'Some text!$' 
.code
start:
mov ax,@DATA 
mov ds,ax 
LEA dx,Hello
MOV ah,09h 
INT 21h
MOV ax,4C00h 
INT 21h
END start