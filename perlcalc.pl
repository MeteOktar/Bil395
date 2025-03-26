#!/usr/bin/perl
use strict;
use warnings;

my %variables;

sub calculate {
    my $expr = shift;
    $expr =~ s/\s+//g;  # Remove all spaces
    if ($expr =~ /^([a-zA-Z]\w*)\s*=\s*(.+)$/) {
        my $var = $1;
        my $value = $2;
        $variables{$var} = evaluate($value);
        return "$var = $variables{$var}";
    }
    return evaluate($expr);
}

sub evaluate {
    my $expr = shift;
    $expr =~ s/([a-zA-Z]\w*)/exists $variables{$1} ? $variables{$1} : $1/ge;  # Substitute variables with their values
    return eval($expr);
}

print "Enter an expression: ";
while (my $input = <STDIN>) {
    chomp $input;
    last if $input eq 'exit';
    print "Result: ", calculate($input), "\n";
    print "Enter an expression: ";
}
