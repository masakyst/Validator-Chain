use strict;
use warnings;
use Test::More;
#use Test::Flatten;
use Validator::Chain;

my $validator = Validator::Chain->new;

# required
$validator->check("")->required("is required");
is(1, $validator->errors_to_i);
$validator->clear();
$validator->check("ok")->required("is required");
is(0, $validator->errors_to_i, 'required success');
$validator->clear();

# length
$validator->check("")->length("length error", 1, 3);
is(1, $validator->errors_to_i, 'length failed');
$validator->clear();
$validator->check("ok")->length("length error", 1, 3);
is(0, $validator->errors_to_i, 'length success');
$validator->clear();

# int
$validator->check("")->int("int error");
is(1, $validator->errors_to_i, 'int failed');
$validator->clear();
$validator->check(1)->int("int error");
is(0, $validator->errors_to_i, 'int success');
$validator->clear();
$validator->check("3")->int("int error");
is(0, $validator->errors_to_i, 'int(from str) success');
$validator->clear();

# uint
$validator->check("")->uint("uint error");
is(1, $validator->errors_to_i, 'uint failed');
$validator->clear();
$validator->check(-1)->uint("uint error");
is(1, $validator->errors_to_i, 'uint failed (unsgined)');
$validator->clear();
$validator->check(1)->uint("uint error");
is(0, $validator->errors_to_i, 'uint success');
$validator->clear();

# ascii
$validator->check("")->ascii("ascii error");
is(1, $validator->errors_to_i, 'ascii failed');
$validator->clear();
$validator->check("abcdefghijk")->ascii("ascii error");
is(0, $validator->errors_to_i, 'ascii success');
$validator->clear();

# email
$validator->check("")->email("email error");
is(1, $validator->errors_to_i, 'email failed');
$validator->clear();
$validator->check('foo..bar.@example.com')->email("email error");
is(1, $validator->errors_to_i, 'email failed');
$validator->clear();
$validator->check('foobar@example.com')->email("email error");
is(0, $validator->errors_to_i, 'email success');
$validator->clear();

# email_loose
$validator->check("")->email_loose("email_loose error");
is(1, $validator->errors_to_i, 'email_loose failed');
$validator->clear();
$validator->check('foo..bar.@example.com')->email_loose("email_loose error");
is(0, $validator->errors_to_i, 'email_loose success');
$validator->clear();
$validator->check('foobar@example.com')->email_loose("email_loose error");
is(0, $validator->errors_to_i, 'email_loose success');
$validator->clear();

# equal
$validator->check("")->equal("equal error", '');
is(0, $validator->errors_to_i, 'equal success(""string)');
$validator->clear();
$validator->check("hello world")->equal("equal error", "hello women");
is(1, $validator->errors_to_i, 'equal failed');
$validator->clear();
$validator->check("hello world")->equal("equal error", "hello world");
is(0, $validator->errors_to_i, 'equal success');
$validator->clear();

done_testing;
