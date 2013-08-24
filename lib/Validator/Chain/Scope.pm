package Validator::Chain::Scope;

use strict;
use warnings;

sub new {
    bless {errors => []}, shift;
}

# error messages attr
sub errors {
    my ($self, $errors) = @_; 
    if (defined $errors) {
        $self->{errors} = $errors;
    }   
    return $self->{errors};
}

# unscoped flush!
sub DESTROY {
    my $self = shift;
}

1
