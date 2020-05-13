model small
stack 256
.data
;???????? ?????? ?????????
telev struc
mark db 30 dup(' ')
price dw ?
made db 30 dup(' ')
telev ends
step=62
;?????????? ????? ??? ?????????
telev1 telev <'LG$',9000,'Made in China$'>
       telev <'Samsung$',10000,'Made in China$'>
       telev <'KIVI$',7500,'Made in China$'>
expan telev <>
.code
FindMax proc near
    xor     ax,ax
    xor     bx,bx
    mov     cx,3
    mov     ax,telev1.price[0]
    jcxz EndFindMax
    xor     si,si
loop1:
    cmp     ax, telev1.price[si]
    jg      next
    mov     ax,telev1.price[si]
    mov     bx, si
next:
    add     si, step
    loop    loop1
EndFindMax:
    mov    expan.price, ax
    ret
endp
main:
    mov ax,@data
    mov ds,ax  
    ;mov es,ax

    call FindMax
    
    mov ah,09h
    lea dx, telev1.mark[bx]
    int 21h
    ;Enter
    mov dl, 10
    mov ah, 02h
    int 21h

    mov ah,09h
    lea dx, telev1.made[bx]
    int 21h

exit:
    mov ax,4c00h
    int 21h
    end main