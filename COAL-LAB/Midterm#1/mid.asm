[org 0x100]
	jmp start

roll: db 7,7,2,1
a: db 0
b: db 0
c: db 0
d: db 0
Mr1: db 0,0
Mr2: db 0,0

Nr1: db 0,0
Nr2: db 0,0

Or1: db 0,0,0
Or2: db 0,0,0
Or3: db 0,0,0
loadmat:
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	
	mov ax,[bp+4]
	mov [Nr1+1],ax

	mov ax,[bp+6]
	mov [Nr1],ax		

	mov ax,[bp+8]
	mov [Mr1+1],ax

	mov ax,[bp+10]
	mov [Mr1],ax

	
	mov ax,[bp+4]
	mov [Mr2+1],ax

	mov ax,[bp+6]
	mov [Mr2],ax		

	mov ax,[bp+8]
	mov [Nr2+1],ax

	mov ax,[bp+10]
	mov [Nr2],ax

	pop cx
	pop bx
	pop ax
	pop bp
	ret 4
matcon:
push bp
	mov bp,sp
	push ax
	push bx
	push cx
mov ax,[Mr1]
mov bx,ax
mul bx
mov [Or1],ax
mov ax,[Mr1+1]
mov bx,[Mr1]
mul bx
shl ax,1
mov [Or1+1],ax
mov ax,[Mr1+1]
mov bx,ax
mul ax
mov [Mr1+2],bx
mov ax,[Mr1]
mov bx,[Mr2]
mul bx
shl ax,1
mov [Or2],ax
mov ax,[Mr1]
mov bx,[Mr2+1]
mul bx
mov bx,[Mr1+1]
mov dx,ax
mov ax,[Mr2]
mul bx
shl ax,1
mov [Or2+1],ax
mov ax,[Mr1+1]
mov bx,[Mr2+1]
mul bx
mov [Or1+2],ax
mov ax,[Mr2]
mov bx,ax
mul bx
mov [Or3],ax
mov ax,[Mr2]
mov bx,[Mr2+1]
mul bx
shl ax,1
mov [Or3+1],ax
mov ax,[Mr2+1]
mov bx,ax
mul bx
mov [Or3+2],ax
                 pop cx
	pop bx
	pop ax
	pop bp
	ret 4

start:
 mov si,0
 mov ax,[roll]
 push ax
 

 mov ax,[roll+1]
 push ax

 mov ax,[roll+2]
 push ax

 mov ax,[roll+3]
 push ax

  call loadmat
  call matcon
mov ax,0x4c00
int 0x21