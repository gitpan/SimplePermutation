package SimplePermutation;

use 5.009000;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use SimplePermutation ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw()],
                     'Permute' => [ qw(Permute) ]
                   );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
 Permute
);

our $VERSION = '0.01';


sub new
{
  my $class = shift;
  my $self = {};
  $self->{array}    = \@_;
  $self->{iterator} = 0;
  $self->{cardinal} = undef;
  bless($self, $class);
  return $self;
}

sub Permute
{
  my $k = shift;
  my @array = @_;
  my $index = $k % ($#array + 1);
  my $rest = int($k / ($#array + 1));
  my $element = $array[$index];
  @array = (@array[0..$index-1] , @array[$index+1 .. $#array]);
  return ($element , SimplePermutation::Permute($rest,@array)) if($#array>=0);
  return $element;
}

sub permutation
{
  my $self = shift;
  my $i = shift;
  return SimplePermutation::Permute($i,@{$self->{array}});

}

sub cur
{
  my $self = shift;
  return SimplePermutation::Permute($self->{iterator},@{$self->{array}});
}

sub prev
{
  my $self = shift;
  return () if($self->{iterator} <= 0);
  $self->{iterator}--;
  return SimplePermutation::Permute($self->{iterator},@{$self->{array}});
}

sub next
{
  my $self = shift;
  return () if($self->{iterator} == $self->cardinal());
  $self->{iterator}++;
  return SimplePermutation::Permute($self->{iterator},@{$self->{array}});
}

sub cardinal
{
  my $self = shift;
  unless(defined $self->{cardinal}){
    my @array=@{$self->{array}};
    $self->{cardinal} = factorial($#array+1);
  }
  return $self->{cardinal};
}

#this part come from:
# www.theperlreview.com/SamplePages/ThePerlReview-v5i1.p23.pdf
# Author: Alberto Manuel Simões
sub factorial {
  my $v = shift;
  my $res = 1;
  while ($v > 1) {
    $res *= $v;
    $v--;
  }
  return $res;
}

1;
__END__

=head1 NAME

SimplePermutation - Perl extension for computing any permutation of an
array.
The permutation could be access by an index in [0,cardinal] or by
iterating with prev, cur and next.


=head1 SYNOPSIS

    use SimplePermutation;

    print "permutation with direct call to Permute\n";
    my $i;
    foreach $i (0..6){
      my @tmp = SimplePermutation::Permute($i,(1,2,3));
      print "@tmp\n";
    }

    print "permutation with counter\n";
    my $p = new SimplePermutation((1,2,3));
    my $i;
    foreach $i (0..$p->cardinal()){
      my @tmp = $p->permutation($i);
      print "@tmp\n";
    }

    print "permutation with next\n";
    my $p = new SimplePermutation((1,2,3));
    my $i;
      my @tmp = $p->cur();
      print "@tmp\n";
    foreach $i (1..$p->cardinal()){
      @tmp = $p->next();
      print "@tmp\n";
    }

the output should be:
    permutation with direct call to Permute
    1 2 3
    2 1 3
    3 1 2
    1 3 2
    2 3 1
    3 2 1
    1 2 3
    permutation with counter
    1 2 3
    2 1 3
    3 1 2
    1 3 2
    2 3 1
    3 2 1
    1 2 3
    permutation with next
    1 2 3
    2 1 3
    3 1 2
    1 3 2
    2 3 1
    3 2 1
    1 2 3


=head1 DESCRIPTION

This module compute the i^{th} permutation of an array recursively.
The main advantage of this module is the fact that you could access to
any permutation in the order that you want.
Moreover this module doesn't use a lot of memory because the permutation
is compute.
the cost for computing one permutation is O(n).

it could be optimize by doing this iteratively but it seems efficient.
Thus this module doesn't need a lot of memory because the permutation
isn't stored.

=head2 EXPORT

Permute [index, @array]
    Returns the index^{th} permutation for the array. This function
    should be called directly as in the exemple.

new [@array]
    Returns a permutor object for the given items.

next
    Called on a permutor, it returns an array contening the next permutation.

prev
    Called on a permutor, it returns an array contening the previous permutation.

cur
    Called on a permutor, it returns an array contening the current permutation.

permutation [index, @array]
    Called on a permutor, it returns the index^{th} permutation for the array.



=head1 SEE ALSO

=item L<Math::Permute::List>

=item L<Algorithm::Permute>

=item L<Algorithm::FastPermute>


=head1 AUTHOR

jean-noel quintin, E<lt>quintin_at___imag_dot___frE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2012 by jean-noel quintin

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.12.4 or,
at your option, any later version of Perl 5 you may have available.


=cut
