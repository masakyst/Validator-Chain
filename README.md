# NAME

Validator::Chain - method chain validation library 

# SYNOPSIS

    use Validator::Chain;
    my $validator = Validator::Chain->new;
    $validator->check("", "name")->required("is invalid");
    print "error numbers: ", $validator->errors_to_i, "\n";
    print "error messages: \n";
    foreach my $message (@{ $validator->errors() }) {
        print $message, "\n";
    }


# DESCRIPTION

Validator::Chain is a simple validation of methods chain


# SEE ALSO

[FormValidator::Lite](http://search.cpan.org/perldoc?FormValidator::Lite), [Validation::Class](http://search.cpan.org/perldoc?Validation::Class)


# LICENSE

Copyright (C) masakyst.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Masaaki Saito <masakyst.public@gmail.com>
