#!/bin/bash
set -e
if [ "$1" = "-c" ]
then
	rm *.o
	echo "Cleared"
else
	echo "Translating..."
	nasm -g -f elf64 -l main.lst $1 -o main.o 
	echo "Compiling..."
	# ld -g -melf_x86_64 -e main -I /lib/ld-linux-x86-64.so.2 -o main main.o -lc
	gcc -m64 -no-pie -o main main.o
	# clear
	echo -e "Running $1.. \n"
	./main
fi