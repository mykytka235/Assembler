MASM
MODEL small
STACK 256
.data
rows=7
cols=4
i dw 0
j dw 0
tmp db ? 
;tmp2d db ?
array db 1, 0, 0, 2
      db 0, 0, 0, 4
      db 6, 0, 0, 0
      db 0, 0, 0, 2
      db 0, 0, 0, 0
      db 0, 0, 0, 1 
      db 0, 0, 0, 0
min db 0
Counter db 4 dup(?)
SortedH db 0ah,0dh,'Sorted the highest values in rows: $'
UnSorted db 0ah,0dh,'Unsorted 2d-array: $'
Zeros db 0ah,0dh,'Min = $'
Sorted db 0ah,0dh,'Sorted 2d-array: $'
.code

FindMin proc near
    xor     ax,ax
    xor     bx,bx
    mov     cx,rows
    mov     al,array[bx][si]
    jcxz EndFindMin
loop_1:
    push    cx
    mov     cx,cols
    xor     si,si
loop_2:
    cmp     al, array[bx][si]
    jl      next
    mov     al,array[bx][si]
next:
    inc     si
    loop    loop_2
    add     bx, cols
    pop     cx
    loop    loop_1 
    EndFindMin:
    mov    min, al
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
    loop    p1          
    ret
endp

Sort proc near32
    mov i, 0
internal:
    mov j,3;????????????? j
    jmp cycl_j ;??????? ?? ???? ?????
exchange:
    mov bx,i ;bx=i
    mov al,Counter[bx] ;ax=mas[i]
    mov bx,j ;bx=j
    cmp al,Counter[bx] ;mas[i] ? mas[j] ? ????????? ?????????
    jle greater ;???? mas[i] ??????, ?? ????? ?? ????? ????? ?? ??????????? ????? ?? ???????
    ;????? tmp=mas[i], mas[i]=mas[j], mas[j]=tmp:
    ;tmp=mas[i]
    
    mov bx,i ;bx=i
    mov tmp,al ;tmp=mas[i]
    
    ;mas[i]=mas[j]
    mov bx,j ;bx=j
    mov al,Counter[bx] ;ax=mas[j]
    mov bx,i ;bx=i
    mov Counter[bx],al ;mas[i]=mas[j]
    
    ;mas[j]=tmp
    mov bx,j ;bx=j
    mov al,tmp ;ax=tmp
    mov Counter[bx],al ;mas[j]=tmp
    
    ;Change columns
    xor bx, bx
    mov cx, 7
swapcols: 
    mov si, i
    ;tmp = a[i][j]
    mov al, array[bx][si]
    mov tmp, al
    ;a[i][j] = a[i][j+1]
    mov si, j
    mov al,array[bx][si] ;ax=mas[j]
    mov si,i ;bx=i
    mov array[bx][si],al ;mas[i]=mas[j]
    ;mas[i][j]=tmp
    mov si, j
    mov al,tmp ;ax=tmp
    mov array[bx][si],al ;mas[j]=tmp
    
    add bx, cols 
    loop swapcols    
    
greater: ;??????????? ????? ?? ??????? ?? ?????????? ?????
     dec j ;j--
;???? ????? ?? j
cycl_j:
    mov ax,j ;ax=j
    cmp ax,i ;???????? j ? i
    jg exchange ;???? j>i, ?? ??????? ?? ?????
    ;????? ?? ??????? ???? ?? i
    inc i ;i++
    cmp i,3 ;???????? i ? n ? ?????? ?? ????? ???????
    jg EndSort
    jmp internal ;???? i
    ;-----------------------------------
EndSort:
    ret
endp

FindPositive proc near 
    xor     ax,ax
    xor     bx,bx
    xor     di,di
    
    mov     cx,cols
r1: ;rows
    
    push    cx
    mov     cx,rows
    xor     si,si
r2: ;columns
    mov     al,array[bx][si]
    cmp     al,0
    jg      lmax
    inc     Counter[di]
lmax:
    add     si, cols
    loop    r2
    inc     di
    inc     bx
    pop     cx
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
    
    call    FindPositive
    call    FindMin
    
    mov     ah,09h
    lea     dx,Zeros
    int     21h
    
    mov     ah, 02h 
    mov     dl, min    
    
    add     dl,30h
    int     21h
   
    call Sort
    ;call SortH
 
    mov ah,09h
    lea dx,SortedH
    int 21h
    ;sorted max-value in row
    mov cx,4
    xor si,si
show: 
    mov dl, Counter[si]
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