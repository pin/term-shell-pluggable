package Super;

sub run_lala {
	die "42\n";
}

package Puper;

use base 'Super';

sub run_tutu {
	die "36\n";
}

package Sub;

use base 'Puper';

sub run_bubu {
	die "52\n";
}

package main;

use Test::More tests => 3;
use Term::Shell::Pluggable;

my $ctx = Term::Shell::Pluggable::Context->new();
$ctx->load_package('Sub');

$ctx->cmd('lala');
is($ctx->{last_cmd_error}, "42\n", 'supersuperclass method call');

$ctx->cmd('tutu');
is($ctx->{last_cmd_error}, "36\n", 'superclass method call');

$ctx->cmd('bubu');
is($ctx->{last_cmd_error}, "52\n", 'class method call');
