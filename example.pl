#!/usr/bin/env perl
package Example;

use warnings;
use strict;

use Getopt::Long qw(GetOptionsFromArray);

sub smry_bubble { 'bubblesort numbers' }
sub run_bubble {
	my $class = shift;
	Getopt::Long::GetOptionsFromArray(\@_,
		'verbose' => \my $verbose,
		'count=s' => \my $count
	) and @_ or die "wrong options or numbers are missing\n" . $class->help_bubble;
	my @numbers = @_;
	for (my $i = 0; $i < @numbers; $i++) {
		for (my $j = 0; $j < @numbers - 1; $j++) {
			if ($numbers[$j] > $numbers[$j + 1]) {
				warn "swap $j and " . ($j + 1) . "\n" if $verbose;
				my $temp = $numbers[$j + 1];
				$numbers[$j + 1] = $numbers[$j];
				$numbers[$j] = $temp;
			}
		}
	}
	print join(' ', @numbers), "\n";
}
sub help_bubble { <<HELP
usage: bubble [-c <times>] [-v] <number> ...
HELP
}

package main;

use Term::Shell::Pluggable;
Term::Shell::Pluggable->run(packages => ['Example']);
