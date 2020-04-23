MODEL small
STACK 256
data segment
     string db 'String which has some (shit) hmm$' ;????? ??? ?????????? ???????
     string2 db 100 dup(' ')
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax, data
    mov ds, ax
 
    lea si,string
    lea di,string2
    mov cx,99
    
    mov cl,string+1 
    mov ch,00h
print:
    mov al, ds:byte ptr[si]
    cmp al, '('
    je Cut
    mov ds:byte ptr[di], al
    inc di
    inc si
    loop print
    cmp al, '$'
    je exit
Cut:
    mov al, ds:byte ptr[si]
    inc si
    cmp al, ')'
    je print
    loop Cut
exit:   
    lea dx,string2
    mov ah,09h
    int 21h
    mov ax, 4c00h
    int 21h
code ends
end start