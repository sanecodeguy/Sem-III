[org 0x0100]
tick: dw 0
second: dw 0
jmp start
delay:
push cx
mov cx,30
delayloop:
push cx
mov cx,0xffff
delayloop2:
loop delayloop2
pop cx
loop delayloop
pop cx
ret
clrscr: push es
        push ax
         push cx
        push di
        mov ax,0xb800
        mov es,ax
       mov di,0
       mov ax,0x0720
       mov cx,2000
       cld
        rep stosw
        pop di
        pop cx
        pop ax
       pop es
       ret
timer:   push ax
         push bx
          push cx
         push dx
          push es
         push si
          push di
          mov ax,0xb800
          mov es,ax
         cmp word[cs:tick],18
         jne near skip
         cmp word[cs:second],79
         je l2
          cmp word[cs:second],103
          je l3
           cmp word[cs:second],182
          je l4
          
        
           mov cx,79
          mov di,0
 loop1:        mov word[es:di],0x072A
                   call delay
           add di,2
         inc word[cs:second]
          loop loop1
         mov word[cs:tick],0
         jmp skip
     
l2:       mov di,316
            mov cx,24
loop2:          mov word[es:di],0x072A
                 call delay
          add di,160
          inc word[cs:second]
          loop loop2
           mov word[cs:tick],0
          jmp skip
l3:      mov di,3996
           mov cx,79
loop3:     mov word[es:di],0x072A
                call delay
           sub di,2
               inc word [cs:second]
           loop loop3
             mov word[cs:tick],0
            jmp skip
l4:      mov di,3840     
         mov cx,24
loop4:    mov word[es:di],0x072A
               call delay
          sub di,160
          inc word [cs:second]
          loop loop4
          jmp end
           
           
skip :     inc word [cs:tick]
      
end:       mov al,0x20
           out 0x20,al
          pop di
          pop si
          pop es
          pop dx
          pop cx

          pop bx         
          pop ax
         iret
start: call clrscr
     mov ax,0
      mov es,ax
      cli 
      mov word [es:8*4],timer 
      mov [es:8*4+2],cs
       sti
      mov ax,0x4c00
      int 21h