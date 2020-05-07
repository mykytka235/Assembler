MASM
MODEL small
STACK 256
.data
rows=3
cols=3
i dw 0
j dw 0
tmp db ? 
;tmp2d db ?
n=8
nH=2
array db 1, 2, 3, 4, 6, 0, 7, 0, 9
nulls db 0
MaxInRow db 3 dup(?)
SortedH db 0ah,0dh,'Sorted the highest values in rows: $'
UnSorted db 0ah,0dh,'Unsorted 2d-array: $'
Zeros db 0ah,0dh,'Number of zeros: $'
Sorted db 0ah,0dh,'Sorted 2d-array: $'
.code
FindNull proc near
    xor     ax,ax
    xor     bx,bx
    mov     cx,rows
    jcxz EndFindNull
loop_1:
    push    cx
    mov     cx,cols
    xor     si,si
loop_2:
    mov     al,array[bx][si]
    cmp     al, 0
    jne     next
    inc     nulls
next:
    inc     si
    loop    loop_2
    add     bx, cols
    pop     cx
    loop    loop_1            ; jump to label @LOOP_1 while CX!=0
EndFindNull:
    ret
endp

Show2DA proc near

    ;Enter
    mov dl, 10
    mov ah, 02h
    int 21h
    xor     ax,ax
    xor     bx,bx
    mov     cx,rows
p1:
    push    cx
    mov     cx,cols
    xor     si,si
p2:
    mov dl, array[bx][si]
    add dl,30h
    mov ah,02h
    int 21h
    mov dx, ' '
    mov ah,02h
    int 21h
nxt:
    inc     si
    loop    p2
    ;Enter
    mov dl, 10
    mov ah, 02h
    int 21h
    add     bx, cols
    pop     cx
    loop    p1            ; jump to label @LOOP_1 while CX!=0

    ret
endp

SortH proc near
    mov i, 0
internalH:
    mov j,2 
    jmp cycl_jH 
exchangeH:
    mov bx,i
    mov al,MaxInRow[bx] 
    mov bx,j 
    cmp al,MaxInRow[bx] 
    jge greaterH 
 
    ;tmp=mas[i]
    mov tmp,al 
    ;mas[i]=mas[j]
    mov bx,j ;bx=j
    mov al,MaxInRow[bx] ;ax=mas[j]
    mov bx,i ;bx=i
    ;mas[i]=mas[j]
    mov MaxInRow[bx],al 
    
    ;mas[j]=tmp
    mov bx,j ;bx=j
    mov al,tmp ;ax=tmp
    mov MaxInRow[bx],al ;mas[j]=tmp
greaterH: 
    dec j ;j--
cycl_jH:
    mov ax,j 
    cmp ax,i 
    jg exchangeH 
    
    inc i 
    cmp i,nH
    jl internalH 


EndSortH:
    ret
endp

Sort proc near
    mov i, 0
internal:
    mov j,n 
    jmp cycl_j 
exchange:
    mov bx,i
    mov al,array[bx] 
    mov bx,j 
    cmp al,array[bx] 
    jge greater 
 
    ;tmp=mas[i]
    mov tmp,al 
    ;mas[i]=mas[j]
    mov bx,j ;bx=j
    mov al,array[bx] ;ax=mas[j]
    mov bx,i ;bx=i
    ;mas[i]=mas[j]
    mov array[bx],al 
    
    ;mas[j]=tmp
    mov bx,j ;bx=j
    mov al,tmp ;ax=tmp
    mov array[bx],al ;mas[j]=tmp
greater: 
    dec j ;j--
cycl_j:
    mov ax,j 
    cmp ax,i 
    jg exchange 
    
    inc i 
    cmp i,n 
    jl internal 
   
EndSort:
    ret
endp
FindHighest proc near 
    xor     ax,ax
    xor     bx,bx
    xor     di,di
    mov     al,array[bx][0]
    mov     cx,rows
r1: ;rows
    
    push    cx
    mov     cx,cols
    xor     si,si
r2: ;columns
    cmp     al,array[bx][si]
    ja      lmax
    mov     al,array[bx][si]
lmax:
    inc     si
    loop    r2
    mov     MaxInRow[di], al
    inc     di
    add     bx, cols
    pop     cx
    mov     al,array[bx][0]
    loop    r1            
    ret
endp


main:
    mov     ax,@data
    mov     ds,ax    
    
    mov ah,09h
    lea dx,UnSorted
    int 21h
    call Show2DA
    
    
    call    FindHighest
    call    FindNull
    
    mov     ah,09h
    lea     dx,Zeros
    int     21h
    
    mov     ah, 02h 
    mov     dl, nulls    
    
    add     dl,30h
    int     21h
   
    call Sort
    call SortH
 
    mov ah,09h
    lea dx,SortedH
    int 21h
    ;sorted max-value in row
    mov cx,3
    xor si,si
show: 
    mov dl, MaxInRow[si]
    add dl,30h
    mov ah,02h
    int 21h
    mov dx, ' '
    mov ah,02h
    int 21h
    inc si    
    loop show
    
    mov ah,09h
    lea dx,Sorted
    int 21h
    call Show2DA
exit:
    mov ax,4c00h 
    int 21h
end main