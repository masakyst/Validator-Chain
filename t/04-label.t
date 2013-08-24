use strict;
use warnings;
use Test::More;
#use Test::Flatten;
use Validator::Chain;

my $validator = Validator::Chain->new;

# required
$validator->check("", "name")->required(" is required");
is(1, $validator->errors_to_i, 'required failed');
is('name is required', $validator->errors()->[0]);
$validator->clear();

$validator->check("123456", "phone")->required(" is required")->length(' is 1 from 5', 1, 5);
is(1, $validator->errors_to_i);
is('phone is 1 from 5', $validator->errors()->[0]);
$validator->clear();

done_testing;
