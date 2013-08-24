package Validator::Chain::Constraint::Core;

use strict;
use warnings;
use Validator::Chain::Constraint;
use Email::Valid;
use Email::Valid::Loose;

constraint 'required' => sub {
    my ($val) = @_;
    return 0 if not defined($val);
    return 0 if $val eq ""; 
    #return 0 if ref($val) eq 'ARRAY' && @$_ == 0; #todo: FVL, Kossy::Validator
    return 1;
};

constraint 'int' => sub {
    my ($val) = @_;
    if ($val =~ /\A[+\-]?[0-9]+\z/) {
        return 1;
    }
    return 0;
};

constraint 'uint' => sub {
    my ($val) = @_;
    if ($val =~ /\A[0-9]+\z/) {
        return 1;
    }
    return 0;
};

constraint 'ascii' => sub {
    my ($val) = @_;
    if ($val =~ /^[\x21-\x7E]+$/) {
        return 1;
    }
    return 0;
};

constraint 'length' => sub {
    my $val = shift;
    my $min = shift;
    my $max = shift || $min;
    Carp::croak("missing \$min") unless defined($min);
    my $len = length $val;
    if ($min <= $len && $len <= $max ) {
        return 1;
    }
    return 0;
};

constraint 'email' => sub {
    my ($val) = @_;
    if (Email::Valid->address($val)) {
        return 1;
    }
    return 0;
};

constraint 'email_loose' => sub {
    my ($val) = @_;
    if (Email::Valid::Loose->address($val)) {
        return 1;
    }
    return 0;
};

constraint 'equal' => sub {
    my ($val, $target) = @_;
    if ($val eq $target) {
        return 1;
    }
    return 0;
};

1;
