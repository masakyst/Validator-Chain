use strict;
use warnings;
use Test::More;
#use Test::Flatten;
use Validator::Chain;

my $validator = Validator::Chain->new;

# case 1
$validator->check("")->required("is required")->length("failed from 1 to 5", 1, 5);
is(1, $validator->errors_to_i);
is('is required', $validator->errors()->[0]);
$validator->clear();

# case 2
$validator->check("123456")->required("is required")->length("failed from 1 to 5", 1, 5);
is(1, $validator->errors_to_i);
is('failed from 1 to 5', $validator->errors()->[0]);
$validator->clear();

# case 3
$validator->check("")->required("is required")->length("from 1 to 5", 1, 5);
is(1, $validator->errors_to_i);
is('is required', $validator->errors()->[0]);
$validator->check("123456")->required("is required")->length("failed from 1 to 5", 1, 5);
is(2, $validator->errors_to_i);
is('failed from 1 to 5', $validator->errors()->[1]);
$validator->clear();

done_testing;
