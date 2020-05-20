model small
stack 256
.data
book struc
autor db 30 dup(' ')
book_name db 32 dup(' ')
book ends
step=62
Books book <'Herbert Schildt$',' C# 4.0 The Complete Reference$'>
      book <'Jeffrey Richter$',' Clr via C#$'>
      book <'Jon Skeet$',' C# in depth$'>
expan book <>
.code
main:
    mov ax,@data
    mov ds,ax  

    xor     ax,ax
    mov     cx,3
    xor     si,si
loop1:
    
    mov ah,09h
    lea dx, Books.autor[si]
    int 21h   

    mov ah,09h
    lea dx, Books.book_name[si]
    int 21h
    
    ;Enter
    mov dl, 10
    mov ah, 02h
    int 21h

    add     si, step
    loop    loop1
exit:
    mov ax,4c00h
    int 21h
    end main