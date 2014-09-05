package Validator::Chain;
use strict;
use warnings;

use Carp ();
use Hash::MultiValue;
use Validator::Chain::Record;
use Validator::Chain::Scope;
use Validator::Chain::Constraint::Core;
use Class::Load ();
use Scalar::Util qw( weaken );

our $VERSION = "0.01";
our $RULES; # nomal hashref

sub new {
    my $class = shift;
    my $self = {
        record    => Validator::Chain::Record->new,
        scope     => Validator::Chain::Scope->new, 
        debug     => 0,
    };
    bless $self, $class;
    return $self;
}

# from FVL 
sub load_constraints {
    my $class = shift;
    for (@_) {
        my $constraint = $_; 
        $constraint = ($constraint =~ s/^\+//) ? $constraint : "Validator::Chain::Constraint::${constraint}";
        Class::Load::load_class($constraint);
    }   
    return $class;
}

sub errors {
    my ($self) = @_;
    return $self->{scope}->errors;
}

sub errors_to_i {
   my ($self) = @_;
   return scalar @{$self->errors()};
}

sub check {
    my ($self, $val, $label) = @_;
    $self->{scope} //= Validator::Chain::Scope->new;
    $label //= '';
    $self->debug("check: value=${val}, label=${label}");
    $self->{record} = Validator::Chain::Record->new(value => $val, label => $label); # initialize record
    return $self;
}

sub not_required {
    my ($self) = @_;
    $self->{record}->{required} = 0;
    return $self;
}

sub add_rule {
    my ($self, $rule_key) = @_;
    $self->{record}->{make_rule} = $rule_key; # make_rule now!
    $Validator::Chain::RULES->{$rule_key} //= Hash::MultiValue->new;
    return $self;
}

sub rule {
    my ($self, $rule_key) = @_;
    $self->{record}->{make_rule} = '';
    $Validator::Chain::RULES->{$rule_key}->each(sub { 
        my ($method, $args) = @_;
        $self->$method(@{$args});
    });
}

sub group {
    my ($self) = @_;
    my $scope = Validator::Chain::Scope->new;
    $self->{scope} = $scope;
    weaken($self->{scope});
    return $self->{scope};
}

sub clear {
    my $self = shift;
    $self->{scope} = Validator::Chain::Scope->new;
    return 1;
}

sub debug {
    my ($self, $msg) = @_;
    Carp::carp($msg) if $self->{debug}; 
}

1;
__END__

=encoding utf-8

=head1 NAME

Validator::Chain - minimalistic data validator

=head1 SYNOPSIS

    use Validator::Chain;
    my $validator = Validator::Chain->new;
    $validator->check("", "name")->required("is invalid");
    print "error numbers: ", $validator->errors_to_i, "\n";
    print "error messages: \n";
    foreach my $message (@{ $validator->errors() }) {
        print $message, "\n";
    }


=head1 DESCRIPTION

Validator::Chain is a verification module which can carry out a method chain. 

=head1 LICENSE

Copyright (C) masakyst.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=head1 AUTHOR

masakyst <masakyst.public@gmail.com>

=cut
