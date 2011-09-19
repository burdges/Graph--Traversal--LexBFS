package Graph::Traversal::LexBFS;

use warnings;
use strict;

=head1 NAME
Graph::Traversal::LexBFS - lexicographic breadth-first traversal of graphs and chordalisty test

=head1 VERSION
Version 0.01
=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use Graph;
    my $g = Graph->new;
    $g->add_edge(...);
    use Graph::Traversal::LexBFS;
    $b->lexbfs($g,$root);

=head1 DESCRIPTION

We implement the chordalisty test using lexicographic breadth-first search
described in :

Habib, Michel; McConnell, Ross; Paul, Christophe; Viennot, Laurent (2000),
"Lex-BFS and partition refinement, with applications to transitive orientation, 
interval graph recognition and consecutive ones testing",
Theoretical Computer Science 234 (1–2): 59–84, doi:10.1016/S0304-3975(97)00241-7.
url : http://www.cs.colostate.edu/~rmm/lexbfs.ps
See also : http://en.wikipedia.org/wiki/Lexicographic_breadth-first_search 

=cut

our(@ISA, @EXPORT_OK);
use Exporter 'import';
@EXPORT_OK = qw(lexbfs is_chordal);

use Graph;
use Set::Object;

=head2 Methods
=over 4
=item lexbfs
Return the graph vertices ordered by lexicographic breadth-first search.
An optional second parameter specifies the initial vertex for the search.
=back
=cut

sub lexbfs {
	my $g = shift @_;
	return () if (! $g->has_vertices);
	my $s = Set::Object->new( $g->vertices );
	my @sets = ( $s ); 
	my @out = ();

	my $v = $_[0] if ($#_ > -1);
	$v = $s->[0] unless $s->member($v);
	while (1) { 
		push(@out,$v); 
		$s->remove($v); 
		my $n = Set::Object->new( $g->neighbours($v) ); 
		@sets = grep { ! $_->is_null }
			map { ($_ * $n, $_ - $n) } @sets;
		# print "$v:"; print @sets; print "\n";
		last if $#sets < 0;
		$s = $sets[0]; 
		$v = $s->[0]; 
	} 
	return @out;
}

=over 4
=item is_chordal
Test whethere a graph is chordalal. 
=back
=cut

sub ordered_list_subset {
	my ($A,$B) = @_;
	my $i = 0;  my $l = $#{$B};
	foreach (@{$A}) {
		while (!($_ eq $B->[$i++])) {  return 0 if ($i > $l);  }
	}
	return 1;
}

sub is_chordal {
	my $g = shift @_;
	my @lexbfs = lexbfs($g,@_); # may use optional paramater for debugging

	# build lists of all rightward/prior neighbors 
	my %priors0 = map { $_ => [] } @lexbfs; 
	my %priors = (); 
	foreach my $v (@lexbfs) {
		$priors{$v} = [ @{$priors0{$v}} ]; # save the priors while correct
		push( @{$priors0{$_}}, $v) foreach ( $g->neighbours($v) );
	}

	foreach my $v (reverse @lexbfs) {
		next if ($#{ $priors{$v} } < 0);
		my @vset = @{$priors{$v}}; 
		my $p = pop @vset; 
		# print "$v:", @vset, " = ", "$p:", @{$priors{$p}};  print "\n";
		return 0 unless ordered_list_subset( \@vset, $priors{$p} );
	}
	return 1;
}

=head1 SEE ALSO
L<Graph::Traversal::BFS>, L<Graph>.

=head1 AUTHOR
Jeffrey Burdges, C<< <burdges at gmail.com> >>

=head1 COPYRIGHT & LICENSE
Copyright 2011 Jeffrey Burdges, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Graph::Traversal::LexBFS
__END__

# Just a reminder that one might want to inheret Graph::Traversal
#
# use Graph::Traversal;
# use base 'Graph::Traversal';
#
# sub current {
#     my $self = shift;
#     $self->{ order }->[ 0 ];
# }
#
# sub see {
#     my $self = shift;
#     shift @{ $self->{ order } };
# }
