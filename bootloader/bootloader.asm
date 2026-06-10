;org 0x7C00
global start
section .text
bits 16
start: jmp boot

msg db "Welcum to Microslop", 0ah, 0dh, 0h

boot:
cli ; no int
cld ; init

mov ax, 0x50 ; PA = ES*N + BX -> 500 -> e_entry -> 518 -> .text-> 600

;set buffer  
mov es, ax
xor bx, bx

mov al, 2 ; read 2 sector: sector count to read
mov ch, 0 ; track
mov cl, 2 ; second sector - sample, first bl
mov dh, 0 ; primary head
mov dl, 0 ; drive num

mov ah, 0x02 ; func to read sector
int 0x13 ; execute
jmp [500h + 18h] ; jmp and execute sector

hlt

times 510 - ($-$$) db 0 ; 510 + 2: sig + reset rest to 0
dw 0xAA55 ; boot sig
