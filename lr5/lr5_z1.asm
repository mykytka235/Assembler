masm
model small              
.stack  128
.data
msg1 db "Enter number five digits:$"
msg2 db "Result is: $"
len=5
mas db 5 dup(?)
b db 5 dup(?)
max db ?
min db ?
rez db ?
rem db 0
tmp db 0
.code
;Reading from console
ReadArray proc near
    mov cx,len 
    xor ax,ax
    xor di,di  
    jcxz EndShowMas
read:
    mov ah,01h
    int 21h
    sub al,30h
    mov mas[di],al   
    inc di
    loop read 
EndReadArray: 
    mov dl, 10
    mov ah, 02h
    int 21h
    ret
endp
;finding max value in array mas
FindMax proc near
    mov cx,len 
    xor ax,ax
    xor si,si  
    jcxz EndFindMax
    mov al, mas[si]    
FindMaxLoop:
    cmp al, mas[si]      
    jg MaxNumber
    mov al, mas[si]
MaxNumber:
    inc si
    loop FindMaxLoop
    mov max,al
EndFindMax:
    ret 
endp
;finding min value in array mas
FindMin proc near
    mov cx,len 
    xor ax,ax
    xor si,si  
    jcxz EndFindMin
    mov al, mas[si]    
FindMinLoop:
    cmp al, mas[si]      
    jl MinNumber
    mov al, mas[si]
MinNumber:
    inc si
    loop FindMinLoop
    mov min,al
EndFindMin:
    ret 
endp
;display result
ShowMas proc near
    mov cx,len 
    xor ax,ax
    xor si,si  
    jcxz EndShowMas
show:
    mov ah,02h 
    mov dl,b[si]    
    
    add dl,30h
    int 21h
    inc si
    loop show   
EndShowMas:
    ret 
endp

start:
    mov ax,@data
    mov ds,ax
     
    mov dx,offset msg1 
    mov ah,09h
    int 21h
    call ReadArray    
    
    call FindMax
    call FindMin
    ;rez = (max+min)/2
    mov al, max
    add al, min
    mov cl, 2
    div cl
    mov rez, al
    ;From mas to b
    mov cx,len 
    xor ax,ax
    xor si,si  
    xor di,di
    mov al, rez
cycl:    
    cmp al, mas[si]
    jg PutInb
    mov bl, mas[si]
    mov b[di], bl
    inc di
PutInb:
    inc si
    loop cycl
    
    mov dx,offset msg2 
    mov ah,09h
    int 21h
    call ShowMas
exit:     
    mov ax,4c00h
    int 21h     
end start