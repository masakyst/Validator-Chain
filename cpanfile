requires 'Scalar::Util', '1.39';
requires 'Hash::MultiValue', '0.15';
requires 'Class::Load', '0.22';
requires 'Email::Valid', '1.194';
requires 'Email::Valid::Loose', '0.05';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

