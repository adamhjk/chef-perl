#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Chef' );
}

diag( "Testing Chef $Chef::VERSION, Perl $], $^X" );
