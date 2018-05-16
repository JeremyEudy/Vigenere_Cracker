#!/usr/bin/perl
#Author: Jeremy Eudy
use warnings;
use strict;
use diagnostics;
use 5.010;
use List::MoreUtils qw(uniq);
no warnings "experimental::autoderef";

#Methods for finding GCD and LCM
sub gcd {
	my ($x, $y) = @_;
	while ($x) { ($x, $y) = ($y % $x, $x); }
	$y;
}
 
sub lcm {
	my ($x, $y) = @_;
	($x && $y) and $x / gcd($x, $y) * $y or 0;
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
my @lcm;
my $keySize;

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

print "\nTrigraphs: @trigraphs\n";

#Put duplicates from @trigraphs in @dups
foreach my $string (@trigraphs) {
	next unless $seen{$string}++;
	$dups[$counter] = $string;
	$counter++;
}
$counter = 0;
@dups = uniq @dups;	#Ensures that @dups only contains one of each trigraph
my $dupString = join("", @dups); #Flattens @dups for future regex
print "\nDupes: @dups\n";

#Finds first and last appearance of duplicate in $cipherText and then subtracts them to find difference
foreach my $trigraph (@trigraphs){
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

while (my ($key, $value) = each %offsets){
	print "$key: $value\n";
}

@lcm = values %offsets; #Retrieve slice of array
for (my $i=0; $i<$#lcm+1; $i++){
	if(exists $lcm[$i+1]){
		$keySize = lcm($lcm[$i], $lcm[$i+1]);
	}
}
print "\nGuessed key size: $keySize\n";
