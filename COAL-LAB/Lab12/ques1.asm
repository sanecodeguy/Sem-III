[org 0x0100]
jmp start
oldisr: dd 0 ; space for saving old isr
sii : dw 0
dii : dw 3840


storescreen:

push bp
mov bp,sp
push si
push di
push cx
push ax
push es
push ds


mov ax,0xb800
mov es,ax
mov ds,ax

mov si,0
mov di,4000

mov cx,2000

cld
rep movsw
pop ds
pop es
pop ax
pop cx
pop di
pop si
pop bp












ret


restore:



push bp
mov bp,sp
push si
push di
push cx
push ax
push es
push ds

mov ax,0xb800
mov es,ax
mov ds,ax

mov si,4000
mov di,0

mov cx,2000

cld
rep movsw
pop ds
pop es
pop ax
pop cx
pop di
pop si

pop bp



ret

moves:

push bp
mov bp,sp
push si
push di
push cx
push ds
push ax
mov cx,0xb800
mov es,cx
mov ds,cx

mov ax,80
mov si,ax
mov si,ax
push si

shl si,1
mov cx,2000
sub cx,ax
mov ax,0xb800
mov es,ax
mov ds,ax
xor di,di

cld

rep movsw
mov ax, 0x0720
pop cx
rep stosw




cld
movsw


add word [cs:sii],2
add word [ds:dii],2



pop ax
pop ds
pop cx
pop di
pop si
pop bp
ret


kbisr:
push ax
push es
mov ax, 0xb800
mov es, ax
in al, 0x60
cmp al, 0x44
jne nextcmp
;mov byte [es:0], 'L'

mov cx,80
mov si,0
mov di,3840
loop1:

mov ax,[es:si]
mov [es:di],ax
add si,2
add di,2
loop loop1
call moves
jmp exit
nextcmp:
cmp al, 0xC4
jne nomatch
;mov byte [es:0], 'R'
call restore
jmp exit

nomatch:
pop es
pop ax
jmp far [cs:oldisr]
exit: mov al, 0x20
out 0x20, al
pop es
pop ax
iret


start:
call storescreen
xor ax, ax
mov es, ax
mov ax, [es:9*4]
mov [oldisr], ax
mov ax, [es:9*4+2]
mov [oldisr+2], ax
cli
mov word [es:9*4], kbisr
mov [es:9*4+2], cs
sti

mov dx, start
add dx, 15;
mov cl, 4
shr dx, cl
mov ax, 0x3100
int 0x21