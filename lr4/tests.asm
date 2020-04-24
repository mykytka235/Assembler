MODEL small
STACK 256
data segment
    string db 'String which has 123 45 hmm$'
    string2 db 100 dup(' ')
    tmp db 'pro'
    counter dw 3
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
    cmp al, 'a'
    je Replace
    cmp al, '1'
    jl MoveOn
    cmp al, '5'
    jg MoveOn
    jle Cut
MoveOn:
    mov ds:byte ptr[di], al
    inc di
    inc si
    cmp al, '$'
    je exit
    loop print
Replace:
    inc si
    mov al, tmp
    mov ds:byte ptr[di], al
    inc di
    mov al, tmp+1
    mov ds:byte ptr[di], al
    inc di
    mov al, tmp+2
    mov ds:byte ptr[di], al
    inc di
    jmp print
Cut:
    mov al, ds:byte ptr[si]
    inc si
    cmp al, '1'
    jl print
    cmp al, '5'
    jg print
    loop Cut
exit:   
    lea dx,string2
    mov ah,09h
    int 21h
    mov ax, 4c00h
    int 21h
code ends
end start