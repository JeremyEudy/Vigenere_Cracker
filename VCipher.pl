# **************************************************************************** #
#                                                                              #
#                                                             |\               #
#    VCipher.pl                                         ------| \----          #
#                                                       |    \`  \  |  p       #
#    By: jeudy2552 <jeudy2552@floridapoly.edu>          |  \`-\   \ |  o       #
#                                                       |---\  \   `|  l       #
#    Created: 2018/05/17 22:37:25 by jeudy2552          | ` .\  \   |  y       #
#    Updated: 2018/09/23 15:54:58 by jeudy2552          -------------          #
#                                                                              #
# **************************************************************************** #
#!/usr/bin/env perl
use warnings;
use strict;
use diagnostics;

my %alphaNum = (
        a => 0, b => 1, c => 2, d => 3, e => 4, f => 5, g => 6, h => 7, i => 8, j => 9, k => 10,
        l => 11, m => 12, n => 13, o => 14, p => 15, q => 16, r => 17, s => 18, t => 19, u => 20,
        v => 21, w => 22, x => 23, y => 24, z => 25,
);
my %revAlphaNum = reverse %alphaNum;
INPUT:
system('clear');
print "Welcome to the Vigenere cipher encoder and decoder.\n1 - Encode\n2 - Decode\n>";
my $inputChoice = <>;
if($inputChoice == 1){
    print "Please input a key: ";
    my $key = <>;
    chomp $key; $key = lc $key;
    print "Please input a message: ";
    my $message = <>; $message = lc $message;
    chomp $message;
    
    my $cipherInt;
    my $cipher;
    my $messageLen = length $message;
    my $keyLen = length $key;
    
    for(my $i=0, my $j=0; $i<$messageLen; $i++, $j++){
        my $letter = substr($message, $i, 1);
    
        if($letter eq " "){
            $j-=1;
            $cipher .= " ";
            next;
        }

        if($j >= $keyLen){
            $j=0;
        }

        my $keyLetter = substr($key, $j, 1);
        my $messageInt = $alphaNum{$letter};
        my $keyInt = $alphaNum{$keyLetter};
        $cipherInt = ($messageInt+$keyInt)%26;
        $cipher .= $revAlphaNum{$cipherInt};
    }
    print "\nYour ciphertext is: $cipher\n";
}
elsif($inputChoice == 2){
    print "Please input a key: ";
    my $key = <>;
    chomp $key; $key = lc $key;
    print "Please input the ciphertext: ";
    my $message = <>; $message = lc $message;
    chomp $message;

    my $plainInt;
    my $plain;
    my $messageLen = length $message;
    my $keyLen = length $key;

    for(my $i=0, my $j=0; $i<$messageLen; $i++, $j++){
        my $letter = substr($message, $i, 1);

        if($letter eq " "){
            $j-=1;
            $plain .= " ";
            next;
        }

        if($j >= $keyLen){
            $j=0;
        }

        my $keyLetter = substr($key, $j, 1);
        my $messageInt = $alphaNum{$letter};
        my $keyInt = $alphaNum{$keyLetter};
        $plainInt = ($messageInt-$keyInt)%26;
        $plain .= $revAlphaNum{$plainInt};
    }
    print "\nYour plaintext is: $plain\n";
    
}
else{
    print "Please input a valid response.\n";
    goto INPUT;
}
exit;
