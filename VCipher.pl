#!/usr/bin/perl
# **************************************************************************** #
#                                                                              #
#                                                             |\               #
#    VCipher.pl                                         ------| \----          #
#                                                       |    \`  \  |  p       #
#    By: jeudy2552 <jeudy2552@floridapoly.edu>          |  \`-\   \ |  o       #
#                                                       |---\  \   `|  l       #
#    Created: 2018/05/22 10:22:42 by jeudy2552          | ` .\  \   |  y       #
#    Updated: 2018/05/22 10:22:42 by jeudy2552          -------------          #
#                                                                              #
# **************************************************************************** #

use warnings;
use strict;
use diagnostics;
use 5.010;
use List::MoreUtils qw(uniq);
no warnings "experimental::autoderef";

#Method for finding GCD
sub gcd {
    my ($x, $y) = @_;
    while ($x) { ($x, $y) = ($y % $x, $x); }
    $y;
}

print "Welcome to the Vigenere Cipher Cracking tool\n";
print "Please input the encoded text: ";
my $cipherText = <>;
my @alpha = ('A' .. 'Z');
$cipherText =~ s/\s+//g; #Remove spaces from string
my $strLength = length $cipherText;
my $offset = $strLength*-1;
$offset+=3;
my $cipherLength = length($cipherText) - 1;
my @trigraphs;
my @dups;
my $counter = 0;
my %seen;
my %offsets;
my @gcd;
my @keySizes;
my %count;
my $keySize;
my @cryptograms;
my %frequency;

#Assemble an array of trigraphs from ciphertext
for (my $i=0; $i<$strLength; $i++){
    if ($offset < 0){
        my $trigraph = substr $cipherText, $i, $offset;
        push @trigraphs, $trigraph;
        #print "$offset ";
        $offset++;
    }
    elsif ($offset == 0){   #this is a separate case because it wasn't including the last trigraph without this statement
        my $trigraph = substr $cipherText, $i;
        push @trigraphs, $trigraph;
        last;
    }
}

#print "\nTrigraphs: @trigraphs\n";

#Put duplicates from @trigraphs in @dups
foreach my $string (@trigraphs) {
    next unless $seen{$string}++;
    $dups[$counter] = $string;
    $counter++;
}
$counter = 0;
@dups = uniq @dups; #Ensures that @dups only contains one of each trigraph
my $dupString = join("", @dups); #Flattens @dups for future regex
#print "\nDupes: @dups\n";

#Finds first and last appearance of duplicate in $cipherText and then subtracts them to find difference
foreach my $trigraph (@dups){
        my @value;
        if( $cipherText =~ m/$trigraph/ && $dupString =~ m/$trigraph/){
            push @value, index($cipherText, $trigraph);
            push @value, rindex($cipherText, $trigraph);
            $offsets{$trigraph} = abs($value[1]-$value[0]);
            $counter++;
            #print "\nValue: @value\n";
        }
}
$counter=0;

#while (my ($key, $value) = each %offsets){
#    print "$key: $value\n";
#}

@gcd = values %offsets; #Retrieve slice of array
$keySizes[0] = gcd($gcd[0], $gcd[1]);
for (my $i=2; $i<$#gcd+1; $i++){
    if(exists $gcd[$i+1]){
        $keySizes[$i-1] = gcd($gcd[$i], $gcd[$i+1]);
        #print "keySize: @keySizes\n";
    }
}

#Determine count for each GCD appearance.
$count{$_}++ foreach @keySizes;

#while (my ($key, $value) = each %count){
#    print "$key: $value\n";
#}

#Retrieve most frequent GCD, which is guessed key size
my @keys = sort { $count{$a} <=> $count{$b} } keys %count;
$keySize = $keys[-1];
print "\nGuessed key size: $keySize\n";

#Assemble array of cryptograms of the same length as $keySize
$offset = $strLength*-1;
$offset+=$keySize;
for (my $i=0; $i<$strLength; $i++){
    if ($offset < 0){
        my $cryptogram = substr $cipherText, $i, $offset;
        my @cryptogramArray = split //, $cryptogram;
        push @cryptograms, \@cryptogramArray;
        #print "$offset ";
        $offset++;
    }
    elsif ($offset == 0){
        my $cryptogram = substr $cipherText, $i;
        my @cryptogramArray = split //, $cryptogram;
        push @cryptograms, \@cryptogramArray;
        last;
    }
}

#Create an array to be used to keep track of letter frequency in relation to position
my @frequencyArray;
for (my $i=0; $i<$keySize; $i++){
    push @frequencyArray, 0;
}
#print "@frequencyArray\n";

for (my $i=0; $i<$#alpha+1; $i++){
    $frequency{$alpha[$i]} = \@frequencyArray;
}
while (my ($key, $value) = each %frequency){
    print "$key: @$value\n";
}

#Need to check letter frequency based on position in cryptograms and store that value in @frequencyArray
for (my $i=0; $i<$#frequencyArray+1; $i++){
    for (my $j=0; $j<$#cryptogramArray+1; $j++){
        
    }
}


