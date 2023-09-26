nasm boot.asm -o boot.bin
pause
qemu-system-x86_64 -drive file=boot.bin,format=raw -monitor stdio -m 256 -no-shutdown -no-reboot -accel hax -L "C:\Program Files\qemu"
