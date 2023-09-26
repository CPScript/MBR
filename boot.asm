; Here we are in assembly!
; This program will display a simple string, which must be NULL terminated in order to properly 
; find the length of it.

; First of all, we need to define the base.
org 0x7c00 ; The base of the program
bits 16    ; 16 bits

; Now let's write our main entrypoint!
start:
	call cls ; Call the CLS function!
	mov bx, display ; Store our message in the BX register
	

; This function will print a string!
; Arguments:
;  BX: The string to print, must be NULL terminated
; Requirements:
;  cls must have been called
print:
	mov al, [bx] ; Dereference the BX string pointer, in C this would look like: al = *bx;
	cmp al, 0 ; Check if the character is a NULL terminator
	je halt ; If it is, jump to the halt function
	call print_char ; Print the current character
	inc bx ; Increase the BX string pointer, in C this would look like: bx++;
	jmp print ; Loop until null terminator found

; This function will be used to print a single characters!
; Arguments:
;  AL: The character to print
print_char:
	mov ah, 0x0e ; Write character function
	int 0x10 ; BIOS interrupt
	ret ; Return


; Returns from the print function
halt:
	ret

; This functions will be used to initialize registries, set colors, etc.
cls:
	mov ah, 0x07   ; Print function
	mov al, 0x00   ; Lines to scroll
	mov bh, 0x04   ; Black background and white color (This can be changed according to the BIOS colors), same as CMD color command!
	mov cx, 0x00   ; Initialize register
	mov dx, 0x184f ; Initialize register
	int 0x10       ; Call the BIOS interrupt!
	ret            ; Return

display db "Your system has been destroyed!", 13, 10, "Like & Subscribe!", 13, 10, 0 ; The null terminator is very important!
times 510 - ($ - $$) db 0 ; Zero remaining sectors
dw 0xaa55 ; Bootable signature

; Now let's try the program!
; Nice! Let's try changing the color of the text!
; Now let's try making a new line. We can not use "\n" since no such escapes are defined.
; Instead, we'll have to use the raw number of it. \n's raw number is 10.
; What happened? It did create a new line, however it continued moving forward along the horizontal axis.
; This is because the \n character actually isn't a single character, (It is, however it can't be printed alone).
; We need a vertical return character as well, \r, which returns the horizontal axis.
; The raw number of the vertical return character is 13. Now let's try it!
; It works!
