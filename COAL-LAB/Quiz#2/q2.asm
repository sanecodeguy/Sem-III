	[org 0x100]
jmp start

copy:
	push ax
	push es
	push bx
	push cx
	push di
	push si

	mov ax,0xb800
	mov es,ax
	xor di,di
	mov si,2880
loop1:
	mov word ax,[es:di]
	mov word [es: si],ax
	add di,2
	add si,2

	cmp si,4000
	jle loop1


	pop si
	pop di
	pop cx
	pop bx
	pop es
	pop ax
ret



start:
	call copy


mov ax,0x4c00
int 21h




	