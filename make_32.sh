#!/bin/bash
set -e
if [ "$1" = "-c" ]
then
	rm *.o
	echo "Cleared"
else
	echo "Translating..."
	nasm -g -f elf -l main.lst $1 -o main.o 
	echo "Compiling..."
	gcc -m32 main.o -o main
	clear
	echo -e "Running $1.. \n"
	./main
fi