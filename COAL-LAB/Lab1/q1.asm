[org 0x0100] ;we will see org directive later
mov ax,3
add ax,6
add ax,9
add ax,12
add ax,15
mov ax, 0x4c00 ;terminate the program
int 0x21
