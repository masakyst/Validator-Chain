use strict;
use warnings;
use Test::More;
use Validator::Chain;

my $validator = Validator::Chain->new;

{
    my $g1 = $validator->group();
    $validator->check("")->required("number is required");
    is(1, $validator->errors_to_i);
    is('number is required', $validator->errors()->[0]);
    $validator->check("123456")->required("number is required")->length("number 1 from 5 length", 1, 5);
    is(2, $validator->errors_to_i);
    is('number 1 from 5 length', $validator->errors()->[1]);
    $validator->check('helloworld@moridehitotsuki.com')->required("email is required")->length("email 1 from 50 length", 1, 50)
        ->email_loose('email not valid');
    is(2, $validator->errors_to_i);
}
{
    my $g2 = $validator->group;
    $validator->check("")->required("is required");
    is(1, $validator->errors_to_i);
    is('is required', $validator->errors()->[0]);
}


done_testing;
