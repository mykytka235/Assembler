; Programm z1
.MODEL SMALL
.CODE
org 100h
begin: jmp start
Hello DB 'Some text!$'
start: 
LEA DX,Hello
MOV AH,09h
INT 21h
MOV AH,4Ch
INT 21h
END begin