#!/usr/bin/env perl

use strict;
use warnings;
use Validator::Chain;
use Data::Dumper;

# rails sample
# http://railsdoc.com/validation
# messages
# https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/ja.yml
# https://github.com/rails/rails/blob/master/activemodel/lib/active_model/locale/en.yml

# print Dumper($Validator::Chain::

my $v = Validator::Chain->new({debug => 1});
print Dumper($v);

# 必須
$v->check("", "name")->required("can't be blank");
$v->check("", "name")->int("must be an integer"); #メソッド名良くないintegerの方がいい
#$v->check("", "name")->number("is not a number"); #も必要そう
$v->check("", "name")->length("is the wrong length (should be [1] character)", 1, 5); #これもメソッド名どうか
$v->check("", "name")->ascii("is the wrong ascii character");
$v->check("", "name")->email("is the wrong email address");
$v->check("", "name")->email_loose("is the wrong email address");
$v->check("", "name")->equal("must be equal to name", 'A');

print "error-msg: ".Dumper($v->errors());
print "error-num: ".Dumper($v->errors_to_i());

# クリアしないとエラー結果配列に追加されていく
#$v->clear();

$v->check("123456", "name")->required("is invalid")->length("is 1 from 5", 1, 5);
print "error-msg: ".Dumper($v->errors());
print "error-num: ".Dumper($v->errors_to_i());

$v->clear();


# group scope
{
    my $g1 = $v->group();
    $v->check("", "name")->required("is invalid");
    print "error-msg: ".Dumper($v->errors());
    print "error-num: ".Dumper($v->errors_to_i());
}

#print Dumper($v);
{
    my $g2 = $v->group();
    $v->check("123456", "name")->required("is invalid")->length("is 1 from 5", 1, 5);
    print "error-msg: ".Dumper($v->errors());
    print "error-num: ".Dumper($v->errors_to_i());
}

# rule
#print Dumper($v);

$v->add_rule("zip")->required("is invalid")->length("is 1 from 5", 1, 5);
$v->add_rule("email")->required("is invalid")->length("is 1 from 50", 1, 50)->email('not email format');
$v->check('hello')->rule('email');
print "error-msg: ".Dumper($v->errors());
print "error-num: ".Dumper($v->errors_to_i());



