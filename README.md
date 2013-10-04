# NAME

Validator::Chain - minimalistic data validator

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

Validator::Chain is a verification module which can carry out a method chain. 

# LICENSE

Copyright (C) masakyst.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

masakyst <masakyst.public@gmail.com>
