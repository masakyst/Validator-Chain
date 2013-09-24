requires 'Scalar::Util';
requires 'Hash::MultiValue';
requires 'Class::Load';
requires 'Email::Valid';
requires 'Email::Valid::Loose';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

