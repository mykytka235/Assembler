MODEL small
STACK 256
data segment
     string db 0ah,100 dup ('$')
     string2 db 100 dup(' ')
data ends
code segment
    assume cs:code,ds:data, es:data
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    mov cx,99
    lea bx,string+1
    mov ah,1
n1:
    int 21h
    mov [bx],al
    inc bx
    cmp al,'.'     ;?? ?????
    je ex
    jcxz exit
    loop n1
ex: 
    lea si,string
    lea di,string2
    mov cx,99
    rep movs string2,string
    lea dx,string2
    mov ah,09h;mov ah,05h ????? ?? ???????,
              ;??? ??? ?? ???????????? ???????? ?????????
              ;???? ? ?????? ?????? ?????? ? ???????
    int 21h
exit:   
    mov ax, 4c00h
    int 21h
code ends
end start