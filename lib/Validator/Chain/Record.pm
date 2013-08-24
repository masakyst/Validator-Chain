package Validator::Chain::Record;

use strict;
use warnings;

sub new {
    my $class = shift;
    my %value_label = @_; 
    my $self = { 
        data      => \%value_label,
        chain     => 1,
        required  => 1,
        make_rule => '', # todo: why string?
    };  
    bless $self, $class;
    return $self;
}

sub DESTROY {
    my $self = shift;
}

1;
