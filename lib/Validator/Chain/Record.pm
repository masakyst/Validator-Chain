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
        make_rule => '',
    };  
    bless $self, $class;
    return $self;
}

1;
