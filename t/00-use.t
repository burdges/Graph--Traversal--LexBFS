#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Graph::Traversal::LexBFS' );
}

diag( "Testing Graph::Traversal::LexBFS $Graph::Traversal::LexBFS::VERSION, Perl $], $^X" );
