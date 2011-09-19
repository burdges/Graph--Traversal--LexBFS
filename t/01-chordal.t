use Test::More tests => 15;

use Graph;
use Graph::Traversal::LexBFS qw(lexbfs is_chordal);

my $g0 = Graph::Undirected->new;
$g0->add_path(qw(a b c));
$g0->add_path(qw(a b d));
$g0->add_path(qw(a e f));
ok is_chordal($g0);
$g0->add_edge(qw(c d));
ok is_chordal($g0);

my $g1 = Graph::Undirected->new; 
$g1->add_path(qw(a b c d)); # path
ok is_chordal($g1);
$g1->add_edge(qw(a d)); # cycle
ok ! is_chordal($g1);
# $g1->add_edge(qw(b d));
$g1->add_edge(qw(a c)); 
ok is_chordal($g1,$_) foreach ($g1->vertices);

my $g2 = Graph::Undirected->new; 
$g2->add_cycle(qw(a b c d e)); # cycle
ok ! is_chordal($g2);
$g2->add_edge(qw(a c));
ok ! is_chordal($g2);
$g2->add_edge(qw(c e));
ok is_chordal($g2,$_) foreach ($g2->vertices);


