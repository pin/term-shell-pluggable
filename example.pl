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

sub smry_levenshtein_distance { 'calculate levenshtein distance between two words' }
sub run_distance {
	my $class = shift;
	my ($w1, $w2) = @_;
	die "please provide two words\n" . $class->help_levenshtein_distance unless defined $w1 and defined $w2;
	print $class->levenshtein_distance($w1, $w2) . "\n";
}
sub help_levenshtein_distance { <<HELP
usage: levenshtein_distance <word1> <word2>
HELP
}

sub levenshtein_distance {
	my $class = shift;
	my ($a, $b) = @_;
	return 0 if $a eq $b;
	my $n = length $a;
	my $m = length $b;
	return $m unless $n;
	return $n unless $m;
	my @d;
	$d[0][0] = 0;
	foreach my $i (1 .. $n) {
		$d[$i][0] = $i;
	}
	foreach my $j (1 .. $m) {
		$d[0][$j] = $j;
	}
	for my $i (1 .. $n) {
		my $a_i = substr($a, $i - 1, 1);
		for my $j (1 .. $m) {
			$d[$i][$j] = min($d[$i - 1][$j] + 1, $d[$i][$j - 1] + 1, $d[$i - 1][$j - 1] + ($a_i eq substr($b, $j - 1, 1) ? 0 : 1))
		}
	}
	return $d[$n][$m];
}

sub min {
	return $_[0] < $_[1] ? $_[0] < $_[2] ? $_[0] : $_[2] : $_[1] < $_[2] ? $_[1] : $_[2];
}

package main;

use Term::Shell::Pluggable;
Term::Shell::Pluggable->run(packages => ['Example']);
