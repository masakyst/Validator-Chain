package Validator::Chain::Constraint;

use strict;
use warnings;

# import constraints
sub import {
    strict->import;
    warnings->import;
    no strict 'refs';
    my $pkg = caller(0);
    *{"$pkg\::constraint"} = \&_constraint;
}

# make constraint
sub _constraint {
    my ($name, $constraint_coderef) = @_;
    no strict 'refs';
    *{"Validator::Chain::${name}"} = sub {
        my $self = shift; 
        # add_rule case (stored rule
        if ($self->{record}->{make_rule}) {
            $self->debug("rule: make ${name}");
            $Validator::Chain::RULES->{ $self->{record}->{make_rule} }->add($name => \@_);    
            return $self;
        }

        # run!
        # before filter
        my $msg  = shift; # error message
        my $record = $self->{record};
        # is not required and none value
        if (!$self->{record}->{required} && length $record->{data}->{value} == 0) {
            $self->debug("chain: stop, not required");
            $self->{record}->{chain} = 0;
        }
        return $self unless $self->{record}->{chain}; # stoped chain
        $self->debug("chain: continue");

        $msg //= "no valid!!!";

        # call original constraint coderef
        my @constraint_args = @_;
        unshift @constraint_args, $record->{data}->{value};
        if ($constraint_coderef->(@constraint_args)) {
            $self->debug("validate: success [${name}]");
        }
        else {
            $self->debug("validate: failed [${name}]");
            my $errors = $self->{scope}->errors();
            my $padding = '';
            if (length $record->{data}->{label} > 0) { $padding = ' '; }
            push @{$errors}, $record->{data}->{label}.$padding.$msg; 
            $self->{scope}->errors($errors);
            $self->{record}->{chain} = 0;
            $self->debug("chain: stop");
        }

        return $self;
    };
}

1;
