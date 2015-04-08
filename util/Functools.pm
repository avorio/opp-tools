package util::Functools;
use strict;
use warnings;
use List::Util qw/min max/;
use Exporter;
our @ISA = ('Exporter');
our @EXPORT_OK = qw/&reduce &someof &allof/;

sub reduce {
    # This does exactly the same thing as List::Util::reduce, except
    # it doesn't reassign $a and $b, and doesn't throw obscure
    # semi-panic warnings.
    my $code = shift;
    my $val = shift;
    foreach (@_) {
	$val = $code->($val, $_);
    }
    return $val;
}

sub someof {
    my @codes = @_;
    return sub {
	my $res = 0;
	foreach my $code (@codes) {
	    next unless ref $code;
	    $res = max($res, $code->(@_) || 0);
	    return 1 if $res == 1;
	}
	return $res;
    }
}

sub allof {
    my @codes = @_;
    return sub {
	my $res = 1;
	foreach my $code (@codes) {
	    next unless ref $code;
	    $res = min($res, $code->(@_) || 0);
	    return 0 if $res == 0;
	}
	return $res;
    }
}
