# Vigenère Cracker
A Perl program for cracking text enciphered with the Vigenère cipher method, and a C program for encoding text with the same method.

## Getting Started
Easy clone:
```
mkdir -p ~/Vigenere_Cracker/ && cd
git clone https://github.com/JeremyEudy/Vigenere_Cracker
```
Or replace ```~/Vigenere_Cracker``` with a different valid location.

### Prerequisites
This project utilizes the List::MoreUtilities Perl library, specifically the "unique" and "indexes" modules.
```
cpan List::MoreUtilities
```
### Usage
VCipher.pl
```
perl VCipher.pl
```
VEncode.pl
```
perl VEncode.pl
```
Project-1-Code--Eudy-Jeremy.c
```
gcc -o VEncode Project-1-Code--Eudy-Jeremy.c
./VEncode
```
### Author
Jeremy Eudy

### License
This project is licensed under the GPLv2
