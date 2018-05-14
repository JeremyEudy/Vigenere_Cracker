#!/usr/bin/perl
#Author: Jeremy Eudy
#This whole thing is broken but idk exactly where. I'm tired.
use warnings;
use strict;
use diagnostics;
use 5.010;
use List::MoreUtils qw(uniq);
use List::MoreUtils qw(indexes);

print "Welcome to the Vigenere Cipher Cracking tool\n";
print "Please input the encoded text: ";
my $cipherText = <>;
my @alpha = ('A' .. 'Z');
$cipherText =~ s/\s+//g; #Remove spaces from string
my $strLength = length $cipherText;
my $offset = $strLength*-1;
$offset+=3;
my @trigraphs;
my @frequency;
my @dups;
my $counter = 0;
my %seen;
my @offsets;
my %trigraphHash;

#Assemble an array of trigraphs from ciphertext
for (my $i=0; $i<$strLength; $i++){
	if ($offset < 0){
		my $trigraph = substr $cipherText, $i, $offset;
		push @trigraphs, $trigraph;
		#print "$offset ";
		$offset++;
	}
	elsif ($offset == 0){	#this is a separate case because it wasn't including the last trigraph without this statement
		my $trigraph = substr $cipherText, $i;
		push @trigraphs, $trigraph;
		last;
	}
}

print "\n@trigraphs\n";

#Put duplicates from @trigraphs in @dups
foreach my $string (@trigraphs) {
	next unless $seen{$string}++;
	$dups[$counter] = $string;
	$counter++;
}

$counter = 0;

@dups = uniq @dups;

print "\n@dups\n";

#this doesn't work and it's breaking here probably
foreach my $trigraph (@trigraphs){
	my( @index )= grep { $trigraphs[$_] eq $trigraph } 0..$#trigraphs;
	$offsets[$counter] = abs($index[1]-$index[0]);
	$counter++;
}

print "\n@offsets\n";

for (my $i=0; $i<@trigraphs; $i++){
	$trigraphHash{$trigraphs[$i]} = $offsets[$i];
}

while (my ($key, $value) = each %trigraphHash){
	print "$key: $value\n";
}


