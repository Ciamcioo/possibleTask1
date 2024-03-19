SYS_EXIT = 1
SYS_READ = 3
SYS_WRITE = 4
STDOUT = 1
STDIN = 0
SYSCALL = 0x80

.bss 
    character: .byte 0 
.text 
.global _start
_start:
    mov $SYS_READ, %eax
    mov $STDIN, %ebx
    mov $character, %ecx
    mov $1, %edx
    int $SYSCALL

    cmp  $0, %eax
    jbe end

    cmpb $65, character 
    jb wrongCharacter

    cmpb $90, character
    jbe bigCharacter 

    cmpb $122, character 
    jbe smallCharacter 

    cmpb $122, character 
    ja wrongCharacter

wrongCharacter: 
    movb $'., character
    jmp display

bigCharacter:
    addb $0x20, character
    jmp display

smallCharacter:
    subb $0x20, character
    jmp display
    


display:
    mov $SYS_WRITE, %eax
    mov $STDOUT, %ebx
    mov $character, %ecx
    mov $1, %edx
    int $SYSCALL
    jmp _start

end:      
    mov $SYS_EXIT, %eax
    int $SYSCALL

