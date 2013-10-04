package Validator::Chain::Scope;

use strict;
use warnings;

sub new {
    bless {errors => []}, shift;
}

sub errors {
    my ($self, $errors) = @_; 
    if (defined $errors) {
        $self->{errors} = $errors;
    }   
    return $self->{errors};
}

1;
