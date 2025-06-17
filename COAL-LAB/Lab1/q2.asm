[org 0x0100] ;we will see org directive later
mov ax,10
mov bx,20
mov cx,30
; rotate once
mov dx,cx
mov cx,bx
mov bx,ax
mov ax,dx
; rotate 2nd time
mov dx,cx
mov cx,bx
mov bx,ax
mov ax,dx
mov ax, 0x4c00 ;terminate the program
int 0x21
