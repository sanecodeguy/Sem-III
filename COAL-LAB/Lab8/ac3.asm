[org 0x0100]
jmp start
message: db 'NAME: Syed Baqir', 0 ; null terminated string
message1: db 'INSTITUTE: Fast School of Computing', 0 ; null terminated string
message2: db 'BATCH: 2021', 0 ; null terminated string
message3: db 'ROLL NO: 21l-7721', 0 ; null terminated string
message4: db 'EMAIL: l217721@lhr.nu.edu.pk', 0 ; null terminated string
message5: db 'ADDRESS: Lahore, Pakistan', 0 ; null terminated string
message6: db 'FEATURES: Ugly', 0 ; null terminated string
somedelay: dw 4
scrollup:
           push bp
           mov bp,sp
           push ax
           push cx
           push si
           push di
           push es
           push ds
           mov ax, 80                 ; load chars per row in ax
           mul byte [bp+4]            ; calculate source position
           mov si, ax                 ; load source position in si
           push si                    ; save position for later use
           shl si, 1                  ; convert to byte offset
           mov cx, 2000               ; number of screen locations
           sub cx, ax                 ; count of words to move
           mov ax, 0xb800
           mov es, ax                 ; point es to video base
           mov ds, ax                 ; point ds to video base
           xor di, di                 ; point di to top left column
           cld                        ; set auto increment mode
           rep movsw                  ; scroll up
           mov ax, 0x0720             ; space in normal attribute
           pop cx                     ; count of positions to clear
           rep stosw                  ; clear the scrolled space
           pop ds
           pop es
           pop di
           pop si
           pop cx
           pop ax
           pop bp
           ret 2

func:
          push bp
          mov bp,sp
          push ax
          push cx

l1:
          cmp word[bp+4],0
          je last
          mov ax,0x002d

l2:
 mov cx,0xfff

l3:
 loop l3
 dec ax
 jnz l2
          dec word[bp+4]
          jmp l1
 
last:
          pop cx
          pop ax
          pop bp
          ret 2

clrscr:
          push es
          push ax
          push cx
          push di
          mov ax, 0xb800
          mov es, ax ; point es to video base
          xor di, di ; point di to top left column
          mov ax, 0x0820 ; space char in normal attribute
          mov cx, 2000 ; number of screen locations
          cld ; auto increment mode
          rep stosw ; clear the whole screen
          pop di
          pop cx
          pop ax
          pop es
          ret
 
; subroutine to calculate the length of a string
; takes the segment and offset of a string as parameters

strlen:
          push bp
          mov bp,sp
          push es
          push cx
          push di
         les di, [bp+4] ; point es:di to string
         mov cx, 0xffff ; load maximum number in cx
         xor al, al ; load a zero in al
         repne scasb ; find zero in the string
         mov ax, 0xffff ; load maximum number in ax
         sub ax, cx ; find change in cx
         dec ax ; exclude null from length
         pop di
         pop cx
         pop es
       pop bp
       ret 4

; subroutine to print a string
; takes the x position, y position, attribute, and address of a null
; terminated string as parameters

printstr:
         push bp
         mov bp, sp
         push es
         push ax
         push cx
         push si
         push di
         push ds ; push segment of string
         mov ax, [bp+4]
         push ax ; push offset of string
         call strlen ; calculate string length
         cmp ax, 0 ; is the string empty
         jz exit ; no printing if string is empty
         mov cx, ax ; save length in cx
         mov ax, 0xb800
         mov es, ax ; point es to video base
         mov al, 80 ; load al with columns per row
         mul byte [bp+8] ; multiply with y position
         add ax, [bp+10] ; add x position
         shl ax, 1 ; turn into byte offset
  mov di,ax ; point di to required location
mov si, [bp+4] ; point si to string
mov ah, [bp+6]        ; load attribute in ah
cld ; auto increment mode

nextchar:
lodsb ; load next char in al
stosw ; print char/attribute pair
loop nextchar ; repeat for the whole string
exit:
pop di
pop si
pop cx
pop ax
  pop es
pop bp
ret 8
start:
call clrscr ; call the clrscr subroutine

mov ax, 30
  push ax ; push x position
  mov ax, 20
  push ax ; push y position
  mov ax, 0x71 ; blue on white attribute
push ax ; push attribute
  mov ax, message
  push ax ; push address of message
  call printstr ; call the printstr subroutine

push word[somedelay]
         call func

mov ax,1
  push ax ; push number of lines to scroll
         call scrollup

         mov ax, 30
         push ax ; push x position
  mov ax, 20
         push ax ; push y position
mov ax, 0x71 ; blue on white attribute
push ax ; push attribute
mov ax, message1
push ax ; push address of message
call printstr ; call the printstr subroutine

push word[somedelay]
call func

mov ax,1
  push ax ; push number of lines to scroll
  call scrollup

mov ax, 30
  push ax ; push x position
  mov ax, 20
  push ax ; push y position
  mov ax, 0x71 ; blue on white attribute
  push ax ; push attribute
        mov ax, message2
  push ax ; push address of message
  call printstr ; call the printstr subroutine

push word[somedelay]
call func

mov ax,1
  push ax ; push number of lines to scroll
call scrollup

mov ax, 30
  push ax ; push x position
  mov ax, 20
  push ax ; push y position
  mov ax, 0x71 ; blue on white attribute
  push ax ; push attribute
  mov ax, message3
  push ax ; push address of message
  call printstr ; call the printstr subroutine

push word[somedelay]
call func

mov ax,1
  push ax ; push number of lines to scroll
  call scrollup

mov ax, 30
  push ax ; push x position
  mov ax, 20
  push ax ; push y position
  mov ax, 0x71 ; blue on white attribute
  push ax ; push attribute
  mov ax, message4
  push ax ; push address of message
  call printstr ; call the printstr subroutine

push word[somedelay]
call func

mov ax,1
  push ax ; push number of lines to scroll
  call scrollup

mov ax, 30
  push ax ; push x position
  mov ax, 20
  push ax ; push y position
  mov ax, 0x71 ; blue on white attribute
  push ax ; push attribute
  mov ax, message5
  push ax ; push address of message
  call printstr ; call the printstr subroutine

push word[somedelay]
call func

mov ax,1
  push ax ; push number of lines to scroll
  call scrollup

mov ax, 30
  push ax ; push x position
  mov ax, 20
  push ax ; push y position
  mov ax, 0x71 ; blue on white attribute
  push ax ; push attribute
  mov ax, message6
  push ax ; push address of message
  call printstr ; call the printstr subroutine

push word[somedelay]
call func

  mov ax, 0x4c00 ; terminate program
  int 0x21 
