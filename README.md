# Vigenère Cracker
A Perl program for cracking text enciphered with the Vigenère cipher method, and a C program for encoding text with the same method. The main part of this project is Cracker.pl. By using statistical analysis of a sufficiently long ciphertext, this program is able to derive the key and decode the message. First the program breaks the ciphertext down into trigraphs and finds duplicate trigraphs. Then the distance between the duplicate trigraphs is measured, these distances are compared to one another to find the most common divisor among them. This is assumed to be the length of the key. The ciphertext is then split into cryptograms of the same length as the key, and the frequency of each letter is measured based on its position in the cryptogram, i.e. if k=5, the letter 'A' would have 5 different numerical values representing its frequency in each possible position in a 5 letter cryptogram. By assuming that the most common letter in each position is "E" (due to it having the highest frequency in the English language), each letter of the key is determined. The ciphertext is then decrypted using the resulting key.

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
# cpan List::MoreUtils
```
### Usage
Cracker.pl
```
perl Cracker.pl
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
