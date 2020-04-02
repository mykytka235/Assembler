OutStack SEGMENT PARA STACK 'STACK'
DB 330 DUP(?)
OutStack ENDS
OutData SEGMENT PARA PUBLIC 'DATA' 
arr1 DB 12 DUP(0)
arr2 DB 12 DUP(1)
arr3 DB 11 DUP(2)
arr4 DB 11 DUP(3)
string1 DB 'I',10,13,'$'
string2 DB 'from',10,13,'$'
string3 DB 'stack',10,13,'$'
OutData ENDS
OutCode SEGMENT PARA PUBLIC 'CODE'    
ASSUME CS:OutCode, DS:OutData, SS:OutStack
Start: 
mov ax, OutData     
mov ds, ax


lea ax, arr1
push ax
lea ax, arr2
push ax
lea ax, arr3
push ax
lea ax, arr4
push ax
lea ax, string3
push ax
lea ax, string2
push ax
lea ax, string1
push ax

mov es, ax 

mov ah,09h
pop dx
int 21h
mov ah,09h
pop dx
int 21h
mov ah,09h
pop dx
int 21h
mov ax, 4c00h 
int 21h

OutCode ENDS
END Start
