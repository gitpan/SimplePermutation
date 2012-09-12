# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl SimplePermutation.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 1;
BEGIN { use_ok('SimplePermutation') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
use SimplePermutation;

print "permutation with direct call to Permutate\n";
my $i;
foreach $i (0..5){
  my @tmp = SimplePermutation::Permute($i,(1,2,3));
  print "@tmp\n";
}

print "permutation with counter\n";
my $p = new SimplePermutation((1,2,3));
foreach $i (0..$p->cardinal()-1){
  my @tmp = $p->permutation($i);
  print "@tmp\n";
}

print "permutation with next\n";
$p = new SimplePermutation((1,2,3));
  my @tmp = $p->cur();
  print "@tmp\n";
foreach $i (1..$p->cardinal()-1){
  @tmp = $p->next();
  print "@tmp\n";
}

print "permutation with prev\n";
while($#tmp != -1){
  print "@tmp\n";
  @tmp = $p->prev();
}

