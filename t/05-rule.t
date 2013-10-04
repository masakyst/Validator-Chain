use strict;
use warnings;
use Test::More;
use Validator::Chain;

my $validator = Validator::Chain->new;

$validator->add_rule("email_address")->required("is required")->length('not from 1 to 10', 1, 10)->email('invalid email');
$validator->check('helloworld@moridehitotsuki.com')->rule('email_address');
is(1, $validator->errors_to_i);
is('not from 1 to 10', $validator->errors()->[0]);
$validator->clear();

$validator->check('hello@e.jp')->rule('email_address');
is(0, $validator->errors_to_i);
$validator->clear();

$validator->check('hello')->rule('email_address');
is(1, $validator->errors_to_i);
is('invalid email', $validator->errors()->[0]);
$validator->clear();

done_testing;
