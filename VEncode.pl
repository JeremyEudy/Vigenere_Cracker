#!/usr/bin/perl
# **************************************************************************** #
#                                                                              #
#                                                             |\               #
#    VEncode.pl                                         ------| \----          #
#                                                       |    \`  \  |  p       #
#    By: jeudy2552 <jeudy2552@floridapoly.edu>          |  \`-\   \ |  o       #
#                                                       |---\  \   `|  l       #
#    Created: 2018/05/17 22:37:25 by jeudy2552          | ` .\  \   |  y       #
#    Updated: 2018/05/17 22:37:25 by jeudy2552          -------------          #
#                                                                              #
# **************************************************************************** #
use warnings;
use strict;
use diagnostics;

my %alphaNum = (
        a => 0, b => 1, c => 2, d => 3, e => 4, f => 5, g => 6, h => 7, i => 8, j => 9, k => 10,
        l => 11, m => 12, n => 13, o => 14, p => 15, q => 16, r => 17, s => 18, t => 19, u => 20,
        v => 21, w => 22, x => 23, y => 24, z => 25,
);
my %revAlphaNum = reverse %alphaNum;

print "Welcome to the Vigenere cipher encoder.\n";
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
    $cipherInt = $messageInt+$keyInt;

    if ($cipherInt>=26){
        $cipherInt = $cipherInt%26;
        $cipher .= $revAlphaNum{$cipherInt};
    }

    else{
        $cipher .= $revAlphaNum{$cipherInt};
    }
}
print "\nYour cipher text is: $cipher\n";
exit;
