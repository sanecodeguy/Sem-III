[org 0x0100]
jmp start



Palindrome1:
push bp
mov bp,sp


mov cx,0
mov si,0
MOV bx,0

mov ax , [bp+4]
mov bh , [bp+4]


first:
shr al,1
jc one1



second:
shl bh,1
jc one2
jmp skip

one1:
mov cx,1
jmp second

one2:
mov si,1


skip:
cmp si,cx
je equal
jmp notequal


equal:
mov bl, 0xAA

notequal:

ret 2




Palindrome2:
push bp
mov bp,sp


mov cx,0
mov si,0
MOV bx,0

mov ax , [bp+4]
mov bh , [bp+4]


first1:
shr al,2
jc one11



second1:
shl bh,2
jc one21
jmp skip1

one11:
mov cx,1
jmp second1

one21:
mov si,1


skip1:
cmp si,cx
je equal1
jmp notequal1


equal1:
mov bl, 0xAA

notequal1:

ret 



Palindrome3:
push bp
mov bp,sp


mov cx,0
mov si,0
MOV bx,0

mov ax , [bp+4]
mov bh , [bp+4]


fir:
shr al,3
jc on



sec:
shl bh,3
jc of
jmp sk

on:
mov cx,1
jmp sec

of:
mov si,1


sk:
cmp si,cx
je equall
jmp nott


equall:
mov bl, 0xAA

nott:

ret 




Palindrome4:
push bp
mov bp,sp


mov cx,0
mov si,0
MOV bx,0

mov ax , [bp+4]
mov bh , [bp+4]


firr:
shr al,4
jc oo



secc:
shl bh,4
jc ooo
jmp skk

oo:
mov cx,1
jmp secc

ooo:
mov si,1


skk:
cmp si,cx
je equalll
jmp nottt


equalll:
mov bl, 0xAA

nottt:

ret 




start:
mov ax,0
mov al, 11100111b
push ax
call Palindrome1
call Palindrome2
call Palindrome3
call Palindrome4
mov ax,0x4c00
int 0x21